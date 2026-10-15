//
//  TopicModel.swift
//  PREPare
//
//  Created by rahdeva on 01/05/26.
//

import Foundation

/// `title`, `category` and `Question.text` hold English source strings that double as
/// keys in Localizable.xcstrings. Display them with `Text(LocalizedStringKey(value))`.
/// The English key is what gets persisted, so saved history follows the in-app language.
struct Topic: Identifiable, Hashable {
    let id: String
    let title: String
    let icon: String
    let category: String
    let categoryOrder: Int
}

struct Question: Identifiable {
    let id: String
    let topicId: String
    let text: String
}
