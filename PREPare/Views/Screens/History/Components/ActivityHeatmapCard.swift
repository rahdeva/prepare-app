import SwiftUI

struct ActivityHeatmapCard: View {
    private let dayLabels = ["M", "W", "F"]
    private let cellSize: CGFloat = 12
    private let cellSpacing: CGFloat = 5
    private let dayLabelWidth: CGFloat = 16

    private let months: [(name: String, weeks: Int)] = [
        ("Jan", 4), ("Feb", 4), ("Mar", 5), ("Apr", 3)
    ]

    private let activityData: [[Int]] = [
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 3, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3, 3, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 3, 1, 0, 0, 0],
    ]

    private func colorForLevel(_ level: Int) -> Color {
        switch level {
        case 1: return Color.green200
        case 2: return Color.green400
        case 3: return Color.green600
        default: return Color.gray200
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Practice Activity")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.slate800)

            VStack(alignment: .leading, spacing: cellSpacing) {
                HStack(spacing: 0) {
                    Spacer().frame(width: dayLabelWidth + 8)
                    ForEach(months, id: \.name) { month in
                        Text(month.name)
                            .font(.caption2)
                            .foregroundStyle(Color.gray500)
                            .frame(
                                width: CGFloat(month.weeks) * (cellSize + cellSpacing),
                                alignment: .leading
                            )
                    }
                    Spacer()
                }

                ForEach(0..<3, id: \.self) { row in
                    HStack(spacing: cellSpacing) {
                        Text(dayLabels[row])
                            .font(.caption2)
                            .foregroundStyle(Color.gray500)
                            .frame(width: dayLabelWidth, alignment: .leading)

                        ForEach(0..<activityData[row].count, id: \.self) { col in
                            Circle()
                                .fill(colorForLevel(activityData[row][col]))
                                .frame(width: cellSize, height: cellSize)
                        }
                    }
                }
            }

            HStack(spacing: 4) {
                Text("Less")
                    .font(.caption2)
                    .foregroundStyle(Color.gray500)

                Circle().fill(Color.green200).frame(width: 10, height: 10)
                Circle().fill(Color.green400).frame(width: 10, height: 10)
                Circle().fill(Color.green600).frame(width: 10, height: 10)

                Text("More")
                    .font(.caption2)
                    .foregroundStyle(Color.gray500)
            }
        }
        .padding(20)
        .background(.white)
        .cornerRadius(16)
        .shadowPrimary()
    }
}

#Preview {
    ActivityHeatmapCard()
        .padding(24)
        .background(Color.slate50)
}
