import SwiftUI

/// Totals shown under the heatmap: sessions, current streak, and best streak.
struct ActivityStatsCard: View {
    let stats: PracticeStats

    var body: some View {
        HStack(spacing: 12) {
            statItem(value: stats.totalSessions, label: "Sessions")
            statItem(value: stats.currentStreak, label: "Current streak")
            statItem(value: stats.longestStreak, label: "Best streak")
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(16)
        .shadowPrimary()
    }

    private func statItem(value: Int, label: LocalizedStringKey) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(value, format: .number)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(Color.slate800)
                .contentTransition(.numericText())

            Text(label)
                .font(.caption)
                .foregroundStyle(Color.gray500)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ActivityStatsCard(stats: PracticeStats(dates: [Date()]))
        .padding(24)
        .background(Color.slate50)
}
