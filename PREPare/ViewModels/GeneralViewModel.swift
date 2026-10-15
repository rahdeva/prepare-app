import Foundation
import SwiftData
import Observation
import UserNotifications

@Observable
final class GeneralViewModel {
    var hasCompletedOnboarding: Bool {
        didSet {
            storage.set(hasCompletedOnboarding, forKey: .hasCompletedOnboarding)
        }
    }

    var selectedLanguage: AppLanguageData {
        didSet {
            storage.set(selectedLanguage.rawValue, forKey: .selectedLanguage)
            // The reminder text is baked into the scheduled notification, so it has to be rebuilt.
            syncDailyReminder()
        }
    }

    private(set) var isDailyReminderEnabled: Bool {
        didSet {
            storage.set(isDailyReminderEnabled, forKey: .dailyReminderEnabled)
        }
    }

    /// Reminder time stored as minutes after midnight, so it is independent of the current date.
    private var dailyReminderMinuteOfDay: Int {
        didSet {
            storage.set(dailyReminderMinuteOfDay, forKey: .dailyReminderMinuteOfDay)
        }
    }

    /// Set when the user turns reminders on while notifications are denied in iOS Settings.
    var isReminderPermissionDenied: Bool = false

    private static let defaultReminderMinuteOfDay = 19 * 60

    private let storage: LocalStorageUtil
    private let notifications = NotificationService()

    init(modelContext: ModelContext) {
        self.storage = LocalStorageUtil(modelContext: modelContext)
        self.hasCompletedOnboarding = storage.getBool(forKey: .hasCompletedOnboarding)
        let languageRaw = storage.getString(forKey: .selectedLanguage) ?? AppLanguageData.english.rawValue
        self.selectedLanguage = AppLanguageData(rawValue: languageRaw) ?? .english
        self.isDailyReminderEnabled = storage.getBool(forKey: .dailyReminderEnabled)
        self.dailyReminderMinuteOfDay = storage.hasValue(forKey: .dailyReminderMinuteOfDay)
            ? storage.getInt(forKey: .dailyReminderMinuteOfDay)
            : Self.defaultReminderMinuteOfDay
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }

    // MARK: - Daily reminder

    /// Today's date at the reminder time, for binding to a time picker.
    var dailyReminderTime: Date {
        get {
            Calendar.current.date(
                bySettingHour: dailyReminderMinuteOfDay / 60,
                minute: dailyReminderMinuteOfDay % 60,
                second: 0,
                of: Date()
            ) ?? Date()
        }
        set {
            let components = Calendar.current.dateComponents([.hour, .minute], from: newValue)
            dailyReminderMinuteOfDay = (components.hour ?? 0) * 60 + (components.minute ?? 0)
            syncDailyReminder()
        }
    }

    func setDailyReminder(enabled: Bool) {
        guard enabled else {
            isDailyReminderEnabled = false
            notifications.cancelDailyReminder()
            return
        }

        Task {
            if await notifications.requestAuthorization() {
                isDailyReminderEnabled = true
                await scheduleDailyReminder()
            } else {
                isDailyReminderEnabled = false
                isReminderPermissionDenied = true
            }
        }
    }

    /// Brings the scheduled notification in line with the stored settings. Called at launch, when the
    /// time or language changes, and when Settings appears in case permission was revoked in iOS Settings.
    func syncDailyReminder() {
        guard isDailyReminderEnabled else { return }

        Task {
            if await notifications.authorizationStatus() == .denied {
                isDailyReminderEnabled = false
                notifications.cancelDailyReminder()
            } else {
                await scheduleDailyReminder()
            }
        }
    }

    private func scheduleDailyReminder() async {
        await notifications.scheduleDailyReminder(
            hour: dailyReminderMinuteOfDay / 60,
            minute: dailyReminderMinuteOfDay % 60,
            locale: selectedLanguage.locale
        )
    }
}
