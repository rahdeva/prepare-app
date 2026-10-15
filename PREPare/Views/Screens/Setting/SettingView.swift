import SwiftUI
import SwiftData

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @Environment(GeneralViewModel.self) private var generalVM
    @Environment(HistoryViewModel.self) private var historyVM
    @State private var showDeleteAlert: Bool = false

    private var dailyReminderBinding: Binding<Bool> {
        Binding(
            get: { generalVM.isDailyReminderEnabled },
            set: { generalVM.setDailyReminder(enabled: $0) }
        )
    }

    private var appVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "-"
    }

    var body: some View {
        @Bindable var vm = generalVM

        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                // Preferences
                SettingSectionHeader(title: "PREFERENCES")

                SettingRow(
                    icon: "bell",
                    title: "Daily Reminders",
                    subtitle: "Get notified to practice",
                    toggle: dailyReminderBinding
                )

                if generalVM.isDailyReminderEnabled {
                    ReminderTimeRow(time: $vm.dailyReminderTime)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }

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
            .animation(.default, value: generalVM.isDailyReminderEnabled)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .localizedNavigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        // Permission may have been revoked in iOS Settings since the toggle was turned on.
        .onAppear { generalVM.syncDailyReminder() }
        .alert("Notifications Are Off", isPresented: $vm.isReminderPermissionDenied) {
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    openURL(url)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Allow notifications for PREPare in Settings to get daily practice reminders.")
        }
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
    let container = PreviewContainer.shared
    NavigationStack {
        SettingView()
    }
    .environment(GeneralViewModel(modelContext: container.mainContext))
    .environment(HistoryViewModel(modelContext: container.mainContext))
}

