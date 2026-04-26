import SwiftUI

struct DetailTimeCard: View {
    let totalTimeSeconds: Int
    let targetTimeSeconds: Int

    private var isOnTime: Bool {
        totalTimeSeconds <= targetTimeSeconds
    }

    private func formatTime(_ seconds: Int) -> String {
        String(format: "%d:%02d", seconds / 60, seconds % 60)
    }

    var body: some View {
        HStack(spacing: 20) {
            VStack(spacing: 4) {
                Text("Total Time")
                    .font(.caption)
                    .foregroundStyle(Color.gray500)

                Text(formatTime(totalTimeSeconds))
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(isOnTime ? Color.green500 : Color.red500)
            }

            VStack(spacing: 4) {
                Text("Target")
                    .font(.caption)
                    .foregroundStyle(Color.gray500)

                Text(formatTime(targetTimeSeconds))
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color.gray400)
            }

            Text(isOnTime ? "On Time" : "Over Time")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(isOnTime ? Color.green600 : Color.red600)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isOnTime ? Color.green100 : Color.red100)
                .cornerRadius(20)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(16)
        .shadowPrimary()
    }
}

#Preview {
    DetailTimeCard(totalTimeSeconds: 120, targetTimeSeconds: 150)
        .padding(24)
        .background(Color.slate50)
}
