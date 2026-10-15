//
//  UITestingLaunchOptions.swift
//  PREPare
//

import Foundation
import SwiftData

/// Launch arguments used by the UI tests to start from a known state. Only honored in Debug builds,
/// so a release build always uses the real store and `UserDefaults.standard`.
///
/// - `-UITesting`: a fresh, separate store and `UserDefaults` suite.
/// - `-UITestingKeepData`: keep the test store and defaults from the previous launch, to test relaunching.
/// - `-UITestingSkipOnboarding`: start as if onboarding was already completed.
/// - `-UITestingSeedHistory`: insert sample sessions for today, yesterday and two days ago.
struct UITestingLaunchOptions {
    static let suiteName = "PREPare.UITesting"

    let isEnabled: Bool
    let keepsData: Bool
    let skipsOnboarding: Bool
    let seedsHistory: Bool

    static var current: UITestingLaunchOptions {
        #if DEBUG
        let arguments = ProcessInfo.processInfo.arguments
        return UITestingLaunchOptions(
            isEnabled: arguments.contains("-UITesting"),
            keepsData: arguments.contains("-UITestingKeepData"),
            skipsOnboarding: arguments.contains("-UITestingSkipOnboarding"),
            seedsHistory: arguments.contains("-UITestingSeedHistory")
        )
        #else
        return UITestingLaunchOptions(isEnabled: false, keepsData: false, skipsOnboarding: false, seedsHistory: false)
        #endif
    }

    var defaults: UserDefaults {
        guard isEnabled, let suite = UserDefaults(suiteName: Self.suiteName) else { return .standard }
        return suite
    }

    /// The real store normally; under UI testing a separate file in Caches, wiped unless `keepsData` is set.
    func modelConfiguration(schema: Schema) -> ModelConfiguration {
        guard isEnabled,
              let caches = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { return ModelConfiguration(schema: schema, isStoredInMemoryOnly: false) }

        let storeURL = caches.appendingPathComponent("UITesting.store")
        if !keepsData {
            for suffix in ["", "-shm", "-wal"] {
                try? FileManager.default.removeItem(at: URL(fileURLWithPath: storeURL.path + suffix))
            }
        }
        return ModelConfiguration(schema: schema, url: storeURL)
    }

    /// Resets the test defaults and seeds data before any view model reads them.
    func prepare(_ context: ModelContext) {
        guard isEnabled, !keepsData else { return }
        defaults.removePersistentDomain(forName: Self.suiteName)
        if skipsOnboarding {
            defaults.set(true, forKey: StorageKeys.hasCompletedOnboarding.rawValue)
        }
        guard seedsHistory else { return }

        let calendar = Calendar.current
        for daysAgo in [0, 1, 2] {
            guard let date = calendar.date(byAdding: .day, value: -daysAgo, to: Date()) else { continue }
            context.insert(PracticeSession(
                topicTitle: "Job Interview",
                questionText: "Tell me about yourself.",
                totalTimeSeconds: 95,
                targetTimeSeconds: 120,
                rating: 4,
                notes: "Seeded session \(daysAgo)",
                date: date,
                stepTranscriptions: ["Point", "Reason", "Example", "Restate"],
                stepDurations: [20, 25, 30, 20]
            ))
        }
        try? context.save()
    }
}
