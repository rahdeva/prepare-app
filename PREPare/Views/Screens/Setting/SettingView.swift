import SwiftUI
import SwiftData

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(GeneralViewModel.self) private var generalVM
    @Environment(HistoryViewModel.self) private var historyVM
    @State private var dailyReminders: Bool = true
    @State private var soundEffects: Bool = true
    @State private var darkMode: Bool = false
    @State private var showDeleteAlert: Bool = false

    private var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "-"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                // Preferences
                SettingSectionHeader(title: "PREFERENCES")

//                SettingRow(
//                    icon: "bell",
//                    title: "Daily Reminders",
//                    subtitle: "Get notified to practice",
//                    toggle: $dailyReminders
//                )
//
//                SettingRow(
//                    icon: "speaker.wave.2",
//                    title: "Sound Effects",
//                    subtitle: "Play sounds during practice",
//                    toggle: $soundEffects
//                )
//
//                SettingRow(
//                    icon: "moon",
//                    title: "Dark Mode",
//                    subtitle: "Switch to a darker appearance",
//                    toggle: $darkMode
//                )

                @Bindable var vm = generalVM
                LanguageSwitchRow(selectedLanguage: $vm.selectedLanguage)

                // Data & Privacy
                SettingSectionHeader(title: "DATA & PRIVACY")
                    .padding(.top, 16)

                SettingRow(
                    icon: "trash",
                    title: "Delete All History",
                    subtitle: "This cannot be undone",
                    style: .destructive,
                    action: { showDeleteAlert = true }
                )

                // About
                SettingSectionHeader(title: "ABOUT")
                    .padding(.top, 16)

                SettingRow(
                    icon: "info.circle",
                    title: "Version",
                    subtitle: LocalizedStringKey(appVersion)
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 24)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .localizedNavigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete All History", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                historyVM.clearAllHistory()
            }
        } message: {
            Text("Are you sure you want to delete all history? This cannot be undone.")
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    NavigationStack {
        SettingView()
    }
    .environment(GeneralViewModel(modelContext: container.mainContext))
    .environment(HistoryViewModel(modelContext: container.mainContext))
}

