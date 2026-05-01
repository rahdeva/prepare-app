import SwiftUI

struct PrimaryButton: View {
    var title: String
    var icon: String? = nil
    var action: (() -> Void)? = nil
    var horizontalPadding: CGFloat = 24
    var bgColor: Color = Color.primaryColor
    var textColor: Color = .white
    var isDisabled: Bool = false

    var body: some View {
        Button(action: { action?() }) {
            HStack() {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.trailing, 4)
                }

                Text(title)
                    .font(.system(size: 18, weight: .bold))
            }
            .foregroundStyle(isDisabled ? .white.opacity(0.5) : textColor)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 60)
            .padding(.horizontal, 8)
            .padding(.vertical, 0)
            .background(isDisabled ? Color.gray : bgColor)
            .cornerRadius(16)
            .shadowPrimary()
        }
        .disabled(isDisabled)
        .padding(.horizontal, horizontalPadding)
    }
}

#Preview {
    PrimaryButton(title: "asdasd", icon: "lightbul", action: {})
}
