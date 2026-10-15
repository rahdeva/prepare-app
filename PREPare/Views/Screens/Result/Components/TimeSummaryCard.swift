import SwiftUI

struct TimeSummaryCard: View {
    let totalTimeSeconds: Int
    let targetTimeSeconds: Int


    var body: some View {
        HStack {
            VStack(spacing: 4) {
                Text("Total Time")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray500)
                    .fontWeight(.semibold)

                Text(clock: totalTimeSeconds)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(totalTimeSeconds > targetTimeSeconds ? Color.errorColor : Color.successColor)
            }
            .frame(maxWidth: .infinity)

            Rectangle()
                .fill(Color.gray300)
                .frame(width: 1, height: 50)

            VStack(spacing: 4) {
                Text("Target Time")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fontWeight(.semibold)

                Text(clock: targetTimeSeconds)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color.primaryColor)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(16)
        .background(.white)
        .cornerRadius(16)
        .shadowPrimary()
    }
}

#Preview {
    NavigationStack {
        ResultView(path: .constant(NavigationPath()))
    }
}
