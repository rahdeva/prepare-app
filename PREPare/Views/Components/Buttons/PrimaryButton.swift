import SwiftUI

struct PrimaryButton: View {
    var title: String
    var icon: String? = nil
    var action: (() -> Void)? = nil
    var horizontalPadding: CGFloat = 24
    
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
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 60)
            .padding(.horizontal, 8)
            .padding(.vertical, 0)
            .background(Color.primaryColor)
            .cornerRadius(16)
            .shadowPrimary()
        }
        .padding(.horizontal, horizontalPadding)
    }
}

#Preview {
    PrimaryButton(title: "asdasd", icon: "lightbul", action: {})
}
