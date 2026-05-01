import Foundation
import SwiftData
import Observation

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
        }
    }

    private let storage: LocalStorageUtil

    init(modelContext: ModelContext) {
        self.storage = LocalStorageUtil(modelContext: modelContext)
        self.hasCompletedOnboarding = storage.getBool(forKey: .hasCompletedOnboarding)
        let languageRaw = storage.getString(forKey: .selectedLanguage) ?? AppLanguageData.english.rawValue
        self.selectedLanguage = AppLanguageData(rawValue: languageRaw) ?? .english
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }
}

