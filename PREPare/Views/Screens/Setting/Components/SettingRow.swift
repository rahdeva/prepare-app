import SwiftUI

enum SettingRowStyle {
    case normal
    case destructive
}

struct SettingRow: View {
    let icon: String
    let title: String
    let subtitle: String
    var style: SettingRowStyle = .normal
    var toggle: Binding<Bool>? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            if let toggle {
                toggle.wrappedValue.toggle()
            }
            action?()
        } label: {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(style == .destructive ? Color.red500 : Color.slate700)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(style == .destructive ? Color.red50 : Color.slate100)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(style == .destructive ? Color.red500 : Color.slate900)

                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.slate400)
                }

                Spacer()

                if let toggle {
                    Toggle("", isOn: toggle)
                        .labelsHidden()
                        .tint(.primaryColor)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(style == .destructive ? Color.red50 : Color.white)
            )
        }
        .buttonStyle(.plain)
        .shadowPrimary()
    }
}
