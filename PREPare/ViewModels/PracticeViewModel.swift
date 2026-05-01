//
//  PracticeViewModel.swift
//  PREPare
//
//  Created by rahdeva on 01/05/26.
//

import Foundation
import Observation

@Observable
final class PracticeViewModel {
    // MARK: - Choose Topic
    var selectedTopic: Topic? = nil
    var selectedQuestion: Question? = nil

    var groupedTopics: [(category: String, topics: [Topic])] {
        let grouped = Dictionary(grouping: TopicData.topics, by: { $0.category })
        return TopicData.categoryOrder.compactMap { category in
            guard let topics = grouped[category] else { return nil }
            return (category: category, topics: topics)
        }
    }

    func pickRandomQuestion() {
        guard let topic = selectedTopic else { return }
        let questions = TopicData.questions.filter { $0.topicId == topic.id }
        selectedQuestion = questions.randomElement()
    }

    // MARK: - Choose Time
    var selectedPrepTime: Int? = 30
    var selectedTargetTime: Int? = 120

    let prepTimes = [0, 10, 20, 30, 60, 90, 120]
    let targetTimes = [60, 90, 120, 180, 300, 600, 900, 1200]

    var totalSeconds: Int {
        (selectedPrepTime ?? 0) + (selectedTargetTime ?? 0)
    }

    func formatTime(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        if m == 0 { return "\(s)s" }
        if s == 0 { return "\(m)m" }
        return "\(m)m \(s)s"
    }

    // MARK: - Reset
    func reset() {
        selectedTopic = nil
        selectedQuestion = nil
        selectedPrepTime = 30
        selectedTargetTime = 120
    }
}
