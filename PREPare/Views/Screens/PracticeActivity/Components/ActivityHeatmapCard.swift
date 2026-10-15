import SwiftUI

/// Calendar heatmap of practice sessions per day, one column per week, ending with the current week.
/// Tapping a dot shows that day's date and number of sessions.
struct ActivityHeatmapCard: View {
    let stats: PracticeStats

    @Environment(\.locale) private var locale
    @State private var availableWidth: CGFloat = 0
    @State private var selectedDate: Date?

    private let cellSize: CGFloat = 12
    private let cellSpacing: CGFloat = 5
    private let dayLabelWidth: CGFloat = 16
    private let labelledRows = [0, 2, 4] // Monday, Wednesday, Friday
    private let minWeeks = 4
    private let maxWeeks = 26

    /// Darker green means more sessions that day. Index is the session count, capped at the last level.
    static let levelColors: [Color] = [.gray200, .green200, .green400, .green600, .green800]

    /// Monday-first calendar whose symbols follow the in-app language.
    private var calendar: Calendar {
        var calendar = Calendar.current
        calendar.locale = locale
        calendar.firstWeekday = 2
        return calendar
    }

    /// As many whole weeks as fit in the card without scrolling.
    private var weekCount: Int {
        let gridWidth = availableWidth - dayLabelWidth - cellSpacing
        guard gridWidth > 0 else { return 16 }
        let fitting = Int((gridWidth + cellSpacing) / (cellSize + cellSpacing))
        return min(maxWeeks, max(minWeeks, fitting))
    }

    /// Week columns, oldest first. Each holds 7 days; `nil` marks a day after today.
    private var weeks: [[Date?]] {
        let calendar = calendar
        let today = calendar.startOfDay(for: Date())
        guard let currentWeekStart = calendar.dateInterval(of: .weekOfYear, for: today)?.start,
              let firstWeekStart = calendar.date(byAdding: .weekOfYear, value: -(weekCount - 1), to: currentWeekStart)
        else { return [] }

        return (0..<weekCount).map { week in
            (0..<7).map { day in
                guard let date = calendar.date(byAdding: .day, value: week * 7 + day, to: firstWeekStart),
                      date <= today
                else { return nil }
                return date
            }
        }
    }

    private struct MonthLabel: Identifiable {
        let id: Int // column index
        let text: String
    }

    /// One label where each new month starts. A label is dropped when the next one would overlap it.
    private func monthLabels(for weeks: [[Date?]]) -> [MonthLabel] {
        let calendar = calendar
        var labels: [MonthLabel] = []
        var previousMonth: Int?

        for (column, week) in weeks.enumerated() {
            guard let weekStart = week[0] else { continue }
            let month = calendar.component(.month, from: weekStart)
            if month != previousMonth {
                if let last = labels.last, column - last.id < 3 {
                    labels.removeLast()
                }
                let text = weekStart.formatted(.dateTime.month(.abbreviated).locale(locale))
                labels.append(MonthLabel(id: column, text: text))
            }
            previousMonth = month
        }
        return labels
    }

    private func daySymbol(row: Int) -> String {
        let calendar = calendar
        let symbols = calendar.veryShortStandaloneWeekdaySymbols
        return symbols[(calendar.firstWeekday - 1 + row) % symbols.count]
    }

    private func color(for date: Date?) -> Color {
        guard let date else { return .clear }
        let level = min(stats.count(on: date), Self.levelColors.count - 1)
        return Self.levelColors[level]
    }

    private func isSelected(_ date: Date?) -> Bool {
        guard let date, let selectedDate else { return false }
        return calendar.isDate(date, inSameDayAs: selectedDate)
    }

    /// Maps a tap inside the dot grid to its day. The whole cell including spacing is the tap target,
    /// which is easier to hit than the 12pt dot alone.
    private func handleTap(at location: CGPoint, in weeks: [[Date?]]) {
        let pitch = cellSize + cellSpacing
        let column = Int((location.x + cellSpacing / 2) / pitch)
        let row = Int((location.y + cellSpacing / 2) / pitch)
        guard weeks.indices.contains(column), (0..<7).contains(row),
              let date = weeks[column][row]
        else { return }

        selectedDate = isSelected(date) ? nil : date
    }

    var body: some View {
        let weeks = weeks

        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: cellSpacing) {
                ZStack(alignment: .leading) {
                    ForEach(monthLabels(for: weeks)) { label in
                        Text(verbatim: label.text)
                            .font(.caption2)
                            .foregroundStyle(Color.gray500)
                            .fixedSize()
                            .offset(x: CGFloat(label.id) * (cellSize + cellSpacing))
                    }
                }
                .frame(height: 14)
                .padding(.leading, dayLabelWidth + cellSpacing)

                HStack(alignment: .top, spacing: cellSpacing) {
                    VStack(spacing: cellSpacing) {
                        ForEach(0..<7, id: \.self) { row in
                            Text(verbatim: labelledRows.contains(row) ? daySymbol(row: row) : "")
                                .font(.caption2)
                                .foregroundStyle(Color.gray500)
                                .frame(width: dayLabelWidth, height: cellSize, alignment: .leading)
                        }
                    }

                    HStack(alignment: .top, spacing: cellSpacing) {
                        ForEach(Array(weeks.enumerated()), id: \.offset) { _, week in
                            VStack(spacing: cellSpacing) {
                                ForEach(0..<7, id: \.self) { row in
                                    Circle()
                                        .fill(color(for: week[row]))
                                        .frame(width: cellSize, height: cellSize)
                                        .overlay {
                                            if isSelected(week[row]) {
                                                Circle()
                                                    .stroke(Color.slate800, lineWidth: 2)
                                                    .frame(width: cellSize + 4, height: cellSize + 4)
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture(coordinateSpace: .local) { location in
                        handleTap(at: location, in: weeks)
                    }
                    .sensoryFeedback(.selection, trigger: selectedDate)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onGeometryChange(for: CGFloat.self) { proxy in
                proxy.size.width
            } action: { width in
                availableWidth = width
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(Text("Practice Activity"))

            selectionDetail

            HStack(spacing: 4) {
                Text("Less")
                    .font(.caption2)
                    .foregroundStyle(Color.gray500)

                ForEach(Self.levelColors.dropFirst().indices, id: \.self) { level in
                    Circle().fill(Self.levelColors[level]).frame(width: 10, height: 10)
                }

                Text("More")
                    .font(.caption2)
                    .foregroundStyle(Color.gray500)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(16)
        .shadowPrimary()
    }

    /// Date and session count of the tapped dot, or a hint when nothing is selected.
    private var selectionDetail: some View {
        HStack(spacing: 12) {
            if let selectedDate {
                let count = stats.count(on: selectedDate)

                Circle()
                    .fill(color(for: selectedDate))
                    .frame(width: 14, height: 14)

                VStack(alignment: .leading, spacing: 2) {
                    Text(verbatim: selectedDate.formatted(
                        .dateTime.weekday(.wide).day().month(.wide).year().locale(locale)
                    ))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.slate800)

                    Group {
                        if count == 0 {
                            Text("No practice")
                        } else {
                            Text("\(count) sessions", comment: "Number of practice sessions on the selected heatmap day.")
                        }
                    }
                    .font(.caption)
                    .foregroundStyle(Color.gray500)
                }
            } else {
                Image(systemName: "hand.tap")
                    .foregroundStyle(Color.gray400)
                Text("Tap a dot to see the details")
                    .font(.caption)
                    .foregroundStyle(Color.gray500)
            }

            Spacer(minLength: 0)
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.slate50)
        )
        .accessibilityElement(children: .combine)
        .animation(.default, value: selectedDate)
    }
}

#Preview {
    let calendar = Calendar.current
    let dates = [0, 0, 1, 2, 4, 5, 5, 5, 5, 9, 15, 16, 30, 45, 46, 60, 80]
        .compactMap { calendar.date(byAdding: .day, value: -$0, to: Date()) }

    ActivityHeatmapCard(stats: PracticeStats(dates: dates))
        .padding(24)
        .background(Color.slate50)
}
