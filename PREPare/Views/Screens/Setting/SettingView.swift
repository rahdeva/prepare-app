import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var dailyReminders: Bool = true
    @State private var soundEffects: Bool = true
    @State private var darkMode: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var selectedLanguage: AppLanguage = .english

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Preferences
                SettingSectionHeader(title: "Preferences")

                SettingRow(
                    icon: "bell",
                    title: "Daily Reminders",
                    subtitle: "Get notified to practice",
                    toggle: $dailyReminders
                )

                SettingRow(
                    icon: "speaker.wave.2",
                    title: "Sound Effects",
                    subtitle: "Play sounds during practice",
                    toggle: $soundEffects
                )

                SettingRow(
                    icon: "moon",
                    title: "Dark Mode",
                    subtitle: "Switch to a darker appearance",
                    toggle: $darkMode
                )

                LanguageSwitchRow(selectedLanguage: $selectedLanguage)

                // Data & Privacy
                SettingSectionHeader(title: "Data & Privacy")
                    .padding(.top, 8)

                SettingRow(
                    icon: "trash",
                    title: "Delete All History",
                    subtitle: "This cannot be undone",
                    style: .destructive,
                    action: { showDeleteAlert = true }
                )

                // About
                SettingSectionHeader(title: "About")
                    .padding(.top, 8)

                SettingRow(
                    icon: "info.circle",
                    title: "Version",
                    subtitle: "1.0.0"
                )
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)
        }
        .background(Color.slate50)
        .navigationTitle("Setting")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete All History", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {}
        } message: {
            Text("Are you sure you want to delete all history? This cannot be undone.")
        }
    }
}

#Preview {
    NavigationStack {
        SettingView()
    }
}

