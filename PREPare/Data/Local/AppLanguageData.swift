//
//  AppLanguageData.swift
//  PREPare
//
//  Created by rahdeva on 01/05/26.
//

import Foundation

enum AppLanguageData: String, CaseIterable {
    case english = "EN"
    case indonesian = "ID"

    /// Language names are shown in their own language, so they are not localized.
    var label: String {
        switch self {
            case .english: "English"
            case .indonesian: "Bahasa Indonesia"
        }
    }

    var flag: String {
        switch self {
            case .english: "🇬🇧"
            case .indonesian: "🇮🇩"
        }
    }

    /// Injected into the SwiftUI environment so every localized view follows the in-app language.
    var locale: Locale {
        switch self {
            case .english: Locale(identifier: "en_GB")
            case .indonesian: Locale(identifier: "id")
        }
    }

    /// Locale used for speech recognition, so transcription follows the in-app language.
    /// Uses the region-qualified identifiers that `SFSpeechRecognizer` supports.
    var speechLocale: Locale {
        switch self {
            case .english: Locale(identifier: "en-US")
            case .indonesian: Locale(identifier: "id-ID")
        }
    }
}
