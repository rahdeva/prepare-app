//
//  ContentAndLocalizationTests.swift
//  PREPareTests
//

import Foundation
import Speech
import UIKit
import Testing
@testable import PREPare

@MainActor
struct TopicDataTests {
    @Test func topicIdsAreUnique() {
        let ids = TopicData.topics.map(\.id)
        #expect(Set(ids).count == ids.count)
    }

    @Test func questionIdsAreUnique() {
        let ids = TopicData.questions.map(\.id)
        #expect(Set(ids).count == ids.count)
    }

    @Test func everyQuestionBelongsToAKnownTopic() {
        let topicIds = Set(TopicData.topics.map(\.id))
        let orphans = TopicData.questions.filter { !topicIds.contains($0.topicId) }
        #expect(orphans.isEmpty, "Orphan questions: \(orphans.map(\.id))")
    }

    @Test(arguments: TopicData.topics)
    func everyTopicHasTenQuestions(topic: Topic) {
        #expect(TopicData.questions.filter { $0.topicId == topic.id }.count == 10)
    }

    @Test func everyTopicCategoryIsOrdered() {
        for topic in TopicData.topics {
            #expect(TopicData.categoryOrder.firstIndex(of: topic.category) == topic.categoryOrder)
        }
    }

    @Test func topicIconsAreValidSymbols() {
        for topic in TopicData.topics {
            #expect(UIImage(systemName: topic.icon) != nil, "Missing SF Symbol \(topic.icon)")
        }
    }
}

@MainActor
struct PREPStepTests {
    @Test func stepsAreInFrameworkOrder() {
        #expect(PREPStep.allCases.map(\.letter) == ["P", "R", "E", "P"])
        #expect(PREPStep.allCases.map(\.number) == [1, 2, 3, 4])
    }

    @Test(arguments: PREPStep.allCases)
    func everyStepHasFourGuidelines(step: PREPStep) {
        #expect(step.guidelines.count == 4)
    }

    @Test func stepCountMatchesStoredArrays() {
        // Sessions store one transcription and duration per step.
        #expect(PREPStep.allCases.count == PracticeViewModel().stepTranscriptions.count)
        #expect(PREPStep.allCases.count == PracticeViewModel().stepDurations.count)
    }
}

@MainActor
struct AppLanguageTests {
    @Test func rawValuesRoundTrip() {
        for language in AppLanguageData.allCases {
            #expect(AppLanguageData(rawValue: language.rawValue) == language)
        }
    }

    @Test(arguments: AppLanguageData.allCases)
    func speechRecognitionSupportsEveryLanguage(language: AppLanguageData) {
        let supported = SFSpeechRecognizer.supportedLocales().map(\.identifier)
        #expect(supported.contains(language.speechLocale.identifier), "\(language.speechLocale.identifier) not supported")
    }

    @Test func localesMatchTranslations() {
        #expect(AppLanguageData.english.locale.language.languageCode == "en")
        #expect(AppLanguageData.indonesian.locale.language.languageCode == "id")
    }
}

/// Topic, category and question strings are stored in English and translated at display time,
/// so every one of them needs an Indonesian entry or it silently shows up in English.
@MainActor
struct LocalizationTests {
    private static let missing = "__MISSING_TRANSLATION__"

    private var indonesianBundle: Bundle? {
        Bundle(for: HistoryViewModel.self).path(forResource: "id", ofType: "lproj").flatMap(Bundle.init(path:))
    }

    private func untranslated(_ keys: [String]) throws -> [String] {
        let bundle = try #require(indonesianBundle, "id.lproj missing from the app bundle")
        return keys.filter { key in
            let value = bundle.localizedString(forKey: key, value: Self.missing, table: "Localizable")
            return value == Self.missing || value == key
        }
    }

    @Test func topicTitlesAreTranslated() throws {
        let missing = try untranslated(TopicData.topics.map(\.title))
        #expect(missing.isEmpty, "Untranslated topics: \(missing)")
    }

    @Test func categoriesAreTranslated() throws {
        let missing = try untranslated(TopicData.categoryOrder)
        #expect(missing.isEmpty, "Untranslated categories: \(missing)")
    }

    @Test func questionsAreTranslated() throws {
        let missing = try untranslated(TopicData.questions.map(\.text))
        #expect(missing.isEmpty, "Untranslated questions: \(missing)")
    }

    @Test func reminderNotificationIsTranslated() {
        let title = String(localized: LocalizedStringResource("Time to practice!", locale: AppLanguageData.indonesian.locale))
        #expect(title != "Time to practice!")
    }
}

@MainActor
struct LocalStorageUtilTests {
    let env: TestEnvironment
    let storage: LocalStorageUtil

    init() throws {
        env = try TestEnvironment()
        storage = env.makeStorage()
    }

    @Test func hasValueDistinguishesZeroFromUnset() {
        #expect(storage.hasValue(forKey: .dailyReminderMinuteOfDay) == false)
        storage.set(0, forKey: .dailyReminderMinuteOfDay)
        #expect(storage.hasValue(forKey: .dailyReminderMinuteOfDay))
        #expect(storage.getInt(forKey: .dailyReminderMinuteOfDay) == 0)
        storage.remove(forKey: .dailyReminderMinuteOfDay)
        #expect(storage.hasValue(forKey: .dailyReminderMinuteOfDay) == false)
    }

    @Test func typedGettersReadBackValues() {
        storage.set(true, forKey: .hasCompletedOnboarding)
        storage.set("ID", forKey: .selectedLanguage)
        #expect(storage.getBool(forKey: .hasCompletedOnboarding))
        #expect(storage.getString(forKey: .selectedLanguage) == "ID")
    }

    @Test func modelCrud() {
        let session = PracticeSession(
            topicTitle: "Teamwork", questionText: "Q", totalTimeSeconds: 1, targetTimeSeconds: 60,
            rating: 0, notes: "", stepTranscriptions: [], stepDurations: []
        )
        storage.insert(session)
        #expect(storage.fetchCount(PracticeSession.self) == 1)
        storage.delete(session)
        #expect(storage.fetchCount(PracticeSession.self) == 0)
    }
}
