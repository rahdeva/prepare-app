import SwiftUI

enum SettingRowStyle {
    case normal
    case destructive
}

struct SettingRow: View {
    let icon: String
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    var style: SettingRowStyle = .normal
    var toggle: Binding<Bool>? = nil
    var action: (() -> Void)? = nil

    private var isDestructive: Bool { style == .destructive }

    var body: some View {
        if toggle != nil || action != nil {
            Button {
                toggle?.wrappedValue.toggle()
                action?()
            } label: {
                content
            }
            .buttonStyle(.plain)
        } else {
            content
        }
    }

    private var content: some View {
        HStack(spacing: 14) {
            SettingIcon(systemName: icon, isDestructive: isDestructive)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(isDestructive ? Color.red600 : Color.slate900)

                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.slate500)
            }

            Spacer(minLength: 8)

            if let toggle {
                Toggle(title, isOn: toggle)
                    .labelsHidden()
                    .tint(.primaryColor)
            } else if action != nil {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.slate400)
            }
        }
        .contentShape(Rectangle())
        .settingCard()
    }
}
