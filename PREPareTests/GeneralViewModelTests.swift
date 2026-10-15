//
//  GeneralViewModelTests.swift
//  PREPareTests
//

import Foundation
import Testing
@testable import PREPare

@MainActor
struct GeneralViewModelTests {
    let env: TestEnvironment

    init() throws {
        env = try TestEnvironment()
    }

    private func makeViewModel() -> GeneralViewModel {
        GeneralViewModel(modelContext: env.context, defaults: env.defaults)
    }

    @Test func freshInstallDefaults() {
        let viewModel = makeViewModel()
        #expect(viewModel.hasCompletedOnboarding == false)
        #expect(viewModel.selectedLanguage == .english)
        #expect(viewModel.isDailyReminderEnabled == false)

        let components = Calendar.current.dateComponents([.hour, .minute], from: viewModel.dailyReminderTime)
        #expect(components.hour == 19)
        #expect(components.minute == 0)
    }

    @Test func onboardingCompletionPersists() {
        makeViewModel().completeOnboarding()
        #expect(makeViewModel().hasCompletedOnboarding)
    }

    @Test func languagePersists() {
        makeViewModel().selectedLanguage = .indonesian
        #expect(env.defaults.string(forKey: StorageKeys.selectedLanguage.rawValue) == "ID")
        #expect(makeViewModel().selectedLanguage == .indonesian)
    }

    @Test func unknownStoredLanguageFallsBackToEnglish() {
        env.defaults.set("FR", forKey: StorageKeys.selectedLanguage.rawValue)
        #expect(makeViewModel().selectedLanguage == .english)
    }

    @Test(arguments: [(0, 0), (7, 5), (12, 30), (23, 59)])
    func reminderTimePersists(hour: Int, minute: Int) {
        let viewModel = makeViewModel()
        viewModel.dailyReminderTime = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!

        #expect(env.defaults.integer(forKey: StorageKeys.dailyReminderMinuteOfDay.rawValue) == hour * 60 + minute)
        let reloaded = Calendar.current.dateComponents([.hour, .minute], from: makeViewModel().dailyReminderTime)
        #expect(reloaded.hour == hour)
        #expect(reloaded.minute == minute)
    }

    @Test func midnightIsNotMistakenForUnset() {
        // 0 minutes is a real choice and must not fall back to the 19:00 default.
        env.defaults.set(0, forKey: StorageKeys.dailyReminderMinuteOfDay.rawValue)
        let components = Calendar.current.dateComponents([.hour, .minute], from: makeViewModel().dailyReminderTime)
        #expect(components.hour == 0)
    }

    @Test func disablingReminderPersistsImmediately() {
        env.defaults.set(true, forKey: StorageKeys.dailyReminderEnabled.rawValue)
        let viewModel = makeViewModel()
        #expect(viewModel.isDailyReminderEnabled)

        viewModel.setDailyReminder(enabled: false)

        #expect(viewModel.isDailyReminderEnabled == false)
        #expect(env.defaults.bool(forKey: StorageKeys.dailyReminderEnabled.rawValue) == false)
    }
}
