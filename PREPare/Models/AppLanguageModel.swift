//
//  AppLanguageModel.swift
//  PREPare
//
//  Created by rahdeva on 01/05/26.
//

enum AppLanguageModel: String, CaseIterable {
    case english = "EN"
    case indonesian = "ID"

    var label: String {
        switch self {
            case .english: "English"
            case .indonesian: "Bahasa Indonesia"
        }
    }

    var flag: String {
        switch self {
            case .english: "🇺🇸"
            case .indonesian: "🇮🇩"
        }
    }
}
