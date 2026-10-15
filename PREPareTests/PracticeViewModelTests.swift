//
//  PracticeViewModelTests.swift
//  PREPareTests
//

import Foundation
import Testing
@testable import PREPare

@MainActor
struct PracticeViewModelTests {
    let viewModel = PracticeViewModel()

    @Test func defaultSetup() {
        #expect(viewModel.selectedTopic == nil)
        #expect(viewModel.selectedQuestion == nil)
        #expect(viewModel.selectedPrepTime == 30)
        #expect(viewModel.selectedTargetTime == 120)
        #expect(viewModel.totalSeconds == 150)
        #expect(viewModel.stepTranscriptions == ["", "", "", ""])
        #expect(viewModel.stepDurations == [0, 0, 0, 0])
    }

    @Test func defaultTimesAreSelectableChips() {
        #expect(viewModel.prepTimes.contains(30))
        #expect(viewModel.targetTimes.contains(120))
        #expect(viewModel.prepTimes == viewModel.prepTimes.sorted())
        #expect(viewModel.targetTimes == viewModel.targetTimes.sorted())
    }

    @Test func groupedTopicsFollowCategoryOrderAndKeepEveryTopic() {
        let groups = viewModel.groupedTopics
        #expect(groups.map(\.category) == TopicData.categoryOrder)
        #expect(groups.flatMap(\.topics).count == TopicData.topics.count)
        for group in groups {
            #expect(group.topics.allSatisfy { $0.category == group.category })
        }
    }

    @Test func noQuestionIsPickedWithoutATopic() {
        viewModel.pickRandomQuestion()
        #expect(viewModel.selectedQuestion == nil)
    }

    @Test(arguments: TopicData.topics)
    func pickedQuestionBelongsToTheSelectedTopic(topic: Topic) throws {
        viewModel.selectedTopic = topic
        for _ in 0..<20 {
            viewModel.pickRandomQuestion()
            let question = try #require(viewModel.selectedQuestion)
            #expect(question.topicId == topic.id)
        }
    }

    @Test func totalSecondsTreatsMissingSelectionAsZero() {
        viewModel.selectedPrepTime = nil
        viewModel.selectedTargetTime = 300
        #expect(viewModel.totalSeconds == 300)
        viewModel.selectedPrepTime = 0
        viewModel.selectedTargetTime = nil
        #expect(viewModel.totalSeconds == 0)
    }

    @Test func resetClearsEverything() {
        fillSession()
        viewModel.reset()

        #expect(viewModel.selectedTopic == nil)
        #expect(viewModel.selectedQuestion == nil)
        #expect(viewModel.selectedPrepTime == 30)
        #expect(viewModel.selectedTargetTime == 120)
        #expect(viewModel.stepTranscriptions == ["", "", "", ""])
        #expect(viewModel.stepDurations == [0, 0, 0, 0])
        #expect(viewModel.totalPracticeTime == 0)
    }

    @Test func practiceAgainKeepsTopicAndTimes() {
        fillSession()
        let topic = viewModel.selectedTopic

        viewModel.prepareForPracticeAgain()

        #expect(viewModel.selectedTopic == topic)
        #expect(viewModel.selectedPrepTime == 10)
        #expect(viewModel.selectedTargetTime == 60)
        #expect(viewModel.selectedQuestion == nil)
        #expect(viewModel.stepTranscriptions == ["", "", "", ""])
        #expect(viewModel.stepDurations == [0, 0, 0, 0])
        #expect(viewModel.totalPracticeTime == 0)
    }

    private func fillSession() {
        viewModel.selectedTopic = TopicData.topics[1]
        viewModel.pickRandomQuestion()
        viewModel.selectedPrepTime = 10
        viewModel.selectedTargetTime = 60
        viewModel.stepTranscriptions = ["a", "b", "c", "d"]
        viewModel.stepDurations = [1, 2, 3, 4]
        viewModel.totalPracticeTime = 10
    }
}
