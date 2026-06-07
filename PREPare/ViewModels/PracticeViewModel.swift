//
//  PracticeViewModel.swift
//  PREPare
//
//  Created by rahdeva on 01/05/26.
//

import Foundation
import AVFoundation
import Speech
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

    // MARK: - Audio Recording & Speech Recognition
    let audioRecorder = AudioRecordingUtil()
    let speechRecognizer = SpeechRecognizerUtil()

    var stepTranscriptions: [String] = ["", "", "", ""]
    var stepDurations: [Int] = [0, 0, 0, 0]
    var totalPracticeTime: Int = 0

    private(set) var isPermissionGranted = false
    private var stepStartTime: Date?

    var currentTranscription: String {
        speechRecognizer.transcribedText
    }

    func requestPermissions() async {
        let micGranted = await withCheckedContinuation { (continuation: CheckedContinuation<Bool, Never>) in
            AVAudioApplication.requestRecordPermission(completionHandler: { granted in
                continuation.resume(returning: granted)
            })
        }
        let speechGranted = await speechRecognizer.requestAuthorization()
        isPermissionGranted = micGranted && speechGranted
    }

    func checkCurrentPermissions() -> Bool {
        let micGranted = AVAudioApplication.shared.recordPermission == .granted
        let speechGranted = SFSpeechRecognizer.authorizationStatus() == .authorized
        isPermissionGranted = micGranted && speechGranted
        return isPermissionGranted
    }

    func startRecordingSession() {
        audioRecorder.onAudioBuffer = { [weak self] buffer in
            self?.speechRecognizer.appendBuffer(buffer)
        }
        do {
            try audioRecorder.startRecording()
            speechRecognizer.startTranscribing()
            stepStartTime = Date()
        } catch {
            print("Failed to start recording: \(error)")
        }
    }

    func advanceStep(currentIndex: Int) {
        let text = speechRecognizer.stopTranscribing()
        stepTranscriptions[currentIndex] = text
        if let start = stepStartTime {
            stepDurations[currentIndex] = Int(Date().timeIntervalSince(start))
        }

        if currentIndex < 3 {
            speechRecognizer.startTranscribing()
            stepStartTime = Date()
        }
    }

    func finishSession(currentIndex: Int, totalTime: Int) {
        let text = speechRecognizer.stopTranscribing()
        stepTranscriptions[currentIndex] = text
        if let start = stepStartTime {
            stepDurations[currentIndex] = Int(Date().timeIntervalSince(start))
        }

        totalPracticeTime = totalTime
        audioRecorder.stopRecording()
    }

    // MARK: - Reset
    func reset() {
        selectedTopic = nil
        selectedQuestion = nil
        selectedPrepTime = 30
        selectedTargetTime = 120

        stepTranscriptions = ["", "", "", ""]
        stepDurations = [0, 0, 0, 0]
        totalPracticeTime = 0
        stepStartTime = nil
    }
}
