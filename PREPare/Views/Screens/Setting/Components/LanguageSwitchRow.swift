import SwiftUI

enum AppLanguage: String, CaseIterable {
    case english = "EN"
    case indonesian = "ID"

    var label: String {
        switch self {
        case .english: "English"
        case .indonesian: "Bahasa Indonesia"
        }
    }

    var flag: String {
        switch self {
        case .english: "🇺🇸"
        case .indonesian: "🇮🇩"
        }
    }
}

struct LanguageSwitchRow: View {
    @Binding var selectedLanguage: AppLanguage

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "globe")
                .font(.system(size: 18))
                .foregroundStyle(Color.slate700)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(Color.slate100)
                )

            VStack(alignment: .leading, spacing: 2) {
                Text("Change Language")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.slate900)

                Text(selectedLanguage.label)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.slate400)
            }

            Spacer()

            Menu {
                ForEach(AppLanguage.allCases, id: \.self) { language in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedLanguage = language
                        }
                    } label: {
                        Label {
                            Text(language.label)
                        } icon: {
                            Text(language.flag)
                        }
                    }
                }
            } label: {
                HStack(spacing: 6) {
                    Text(selectedLanguage.flag)
                        .font(.system(size: 16))
                    Text(selectedLanguage.rawValue)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.slate700)
                    Image(systemName: "chevron.down")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(Color.slate400)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.slate100)
                )
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
        )
        .shadowPrimary()
    }
}
