//
//  TopicModel.swift
//  PREPare
//
//  Created by rahdeva on 01/05/26.
//

import Foundation

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
