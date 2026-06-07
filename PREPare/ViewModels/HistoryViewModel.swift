//
//  HistoryViewModel.swift
//  PREPare
//
//  Created by rahdeva on 01/05/26.
//

import Foundation
import SwiftData
import Observation

@Observable
final class HistoryViewModel {
    private let storage: LocalStorageUtil
    var sessions: [PracticeSession] = []

    init(modelContext: ModelContext) {
        self.storage = LocalStorageUtil(modelContext: modelContext)
        fetchSessions()
    }

    func fetchSessions() {
        sessions = storage.fetchAll(
            PracticeSession.self,
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
    }

    func saveSession(
        topicTitle: String,
        questionText: String,
        totalTimeSeconds: Int,
        targetTimeSeconds: Int,
        rating: Int,
        notes: String,
        stepTranscriptions: [String],
        stepDurations: [Int],
        recordingURL: URL?
    ) {
        var recordingFileName: String? = nil
        if let sourceURL = recordingURL {
            recordingFileName = copyRecordingToDocuments(from: sourceURL)
        }

        let session = PracticeSession(
            topicTitle: topicTitle,
            questionText: questionText,
            totalTimeSeconds: totalTimeSeconds,
            targetTimeSeconds: targetTimeSeconds,
            rating: rating,
            notes: notes,
            stepTranscriptions: stepTranscriptions,
            stepDurations: stepDurations,
            recordingFileName: recordingFileName
        )

        storage.insert(session)
        fetchSessions()
    }

    func clearAllHistory() {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        for session in sessions {
            if let fileName = session.recordingFileName, let dir = documentsURL {
                try? FileManager.default.removeItem(at: dir.appendingPathComponent(fileName))
            }
        }

        storage.deleteAll(PracticeSession.self)
        sessions = []
    }

    private func copyRecordingToDocuments(from sourceURL: URL) -> String? {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        let fileName = "\(UUID().uuidString).caf"
        let destinationURL = documentsURL.appendingPathComponent(fileName)

        do {
            try FileManager.default.copyItem(at: sourceURL, to: destinationURL)
            return fileName
        } catch {
            print("Failed to copy recording: \(error)")
            return nil
        }
    }
}
