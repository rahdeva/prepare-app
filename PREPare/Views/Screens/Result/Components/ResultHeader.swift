import SwiftUI

struct ResultHeader: View {
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(Color.green500)
                    .frame(width: 80, height: 80)

                Image(systemName: "checkmark")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(.white)
            }

            Text("Great Job!")
                .font(.system(size: 24, weight: .bold))

            Text("You completed your practice session")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        ResultView(path: .constant(NavigationPath()))
    }
}
