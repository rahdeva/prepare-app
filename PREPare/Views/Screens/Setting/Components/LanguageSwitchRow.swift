import SwiftUI

struct LanguageSwitchRow: View {
    @Binding var selectedLanguage: AppLanguageData

    var body: some View {
        HStack(spacing: 14) {
            SettingIcon(systemName: "globe")

            VStack(alignment: .leading, spacing: 2) {
                Text("Change Language")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Color.slate900)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)

                Text(selectedLanguage.label)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.slate500)
                    .lineLimit(1)
            }
            .layoutPriority(1)

            Spacer(minLength: 8)

            // Menu items don't depend on the selection or the locale, so UIKit never has to update
            // the menu while it is dismissing after a choice.
            Menu {
                ForEach(AppLanguageData.allCases, id: \.self) { language in
                    Button {
                        selectedLanguage = language
                    } label: {
                        Text(verbatim: "\(language.flag)  \(language.label)")
                    }
                }
            } label: {
                HStack(spacing: 5) {
                    Text(selectedLanguage.flag)
                        .font(.system(size: 15))
                    Text(selectedLanguage.rawValue)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.slate800)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.slate500)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.slate100)
                )
            }
            .accessibilityLabel(Text("Change Language"))
            .accessibilityValue(Text(selectedLanguage.label))
        }
        .settingCard()
    }
}
