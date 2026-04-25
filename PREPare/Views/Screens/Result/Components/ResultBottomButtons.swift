import SwiftUI

struct ResultBottomButtons: View {
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 12) {
            PrimaryButton(
                title: "Save & Back to Home",
                action: {
                    path = NavigationPath()
                }
            )

            Button(action: {
                if path.count > 0 {
                    path.removeLast()
                }
            }) {
                Text("Practice Again")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(Color.primaryColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.white)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.primaryColor, lineWidth: 2)
                    )
            }
            .padding(.horizontal, 24)
        }
        .padding(.top, 12)
        .padding(.bottom, 16)
        .background(
            Color.clear
        )
    }
}
