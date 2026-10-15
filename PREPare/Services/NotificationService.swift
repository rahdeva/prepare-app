//
//  NotificationService.swift
//  PREPare
//

import Foundation
import UserNotifications

/// Schedules the daily practice reminder as a repeating local notification.
final class NotificationService {
    static let dailyReminderIdentifier = "dailyPracticeReminder"

    private let center = UNUserNotificationCenter.current()

    func authorizationStatus() async -> UNAuthorizationStatus {
        await center.notificationSettings().authorizationStatus
    }

    /// Prompts for permission only if the user hasn't decided yet. Returns whether notifications are allowed.
    func requestAuthorization() async -> Bool {
        switch await authorizationStatus() {
        case .authorized, .provisional, .ephemeral:
            return true
        case .denied:
            return false
        case .notDetermined:
            return (try? await center.requestAuthorization(options: [.alert, .sound, .badge])) ?? false
        @unknown default:
            return false
        }
    }

    /// Replaces any existing reminder. The text is resolved with the in-app language rather than
    /// the system language, so it matches what the user sees in the app.
    func scheduleDailyReminder(hour: Int, minute: Int, locale: Locale) async {
        cancelDailyReminder()

        let content = UNMutableNotificationContent()
        content.title = String(localized: LocalizedStringResource(
            "Time to practice!",
            locale: locale,
            comment: "Daily reminder notification title."
        ))
        content.body = String(localized: LocalizedStringResource(
            "Take a few minutes to practice speaking with PREP today.",
            locale: locale,
            comment: "Daily reminder notification body."
        ))
        content.sound = .default

        var components = DateComponents()
        components.hour = hour
        components.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let request = UNNotificationRequest(
            identifier: Self.dailyReminderIdentifier,
            content: content,
            trigger: trigger
        )

        do {
            try await center.add(request)
        } catch {
            print("Failed to schedule daily reminder: \(error)")
        }
    }

    func cancelDailyReminder() {
        center.removePendingNotificationRequests(withIdentifiers: [Self.dailyReminderIdentifier])
    }
}
