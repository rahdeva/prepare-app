//
//  PracticeSessionModel.swift
//  PREPare
//
//  Created by rahdeva on 03/05/26.
//

import Foundation
import SwiftData

@Model
final class PracticeSession {
    var id: UUID
    var topicTitle: String
    var questionText: String
    var totalTimeSeconds: Int
    var targetTimeSeconds: Int
    var rating: Int
    var notes: String
    var date: Date
    var stepTranscriptions: [String]
    var stepDurations: [Int]
    var recordingFileName: String?

    init(
        topicTitle: String,
        questionText: String,
        totalTimeSeconds: Int,
        targetTimeSeconds: Int,
        rating: Int,
        notes: String,
        date: Date = Date(),
        stepTranscriptions: [String],
        stepDurations: [Int],
        recordingFileName: String? = nil
    ) {
        self.id = UUID()
        self.topicTitle = topicTitle
        self.questionText = questionText
        self.totalTimeSeconds = totalTimeSeconds
        self.targetTimeSeconds = targetTimeSeconds
        self.rating = rating
        self.notes = notes
        self.date = date
        self.stepTranscriptions = stepTranscriptions
        self.stepDurations = stepDurations
        self.recordingFileName = recordingFileName
    }

    var recordingURL: URL? {
        guard let fileName = recordingFileName else { return nil }
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent(fileName)
    }

    var formattedShortDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date)
    }

    var formattedFullDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
}
