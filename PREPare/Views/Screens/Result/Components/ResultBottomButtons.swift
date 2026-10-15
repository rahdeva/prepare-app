import SwiftUI

struct ResultBottomButtons: View {
    @Binding var path: NavigationPath
    let onSave: () -> Void
    let onPracticeAgain: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            // The session was saved when the result screen appeared; both buttons store the final evaluation.
            PrimaryButton(
                title: "Practice Again",
                action: {
                    onSave()
                    onPracticeAgain()
                    // Home is the stack root, so this lands on Choose Topic with the previous topic still selected.
                    path = NavigationPath([AppRoute.chooseTopic])
                }
            )

            Button(action: {
                onSave()
                path = NavigationPath()
            }) {
                Text("Back to Home")
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
