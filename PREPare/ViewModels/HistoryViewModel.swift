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
            recordingFileName = moveRecordingToDocuments(from: sourceURL)
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

    /// Moves the finished recording out of the temporary directory (which iOS may purge)
    /// into Documents. Only the file name is stored, because the container path can change
    /// between app launches.
    private func moveRecordingToDocuments(from sourceURL: URL) -> String? {
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        let size = (try? fileManager.attributesOfItem(atPath: sourceURL.path)[.size] as? Int) ?? 0
        guard size > 0 else {
            print("Recording is missing or empty, not saving: \(sourceURL.lastPathComponent)")
            return nil
        }

        let fileExtension = sourceURL.pathExtension.isEmpty ? "m4a" : sourceURL.pathExtension
        let fileName = "\(UUID().uuidString).\(fileExtension)"
        let destinationURL = documentsURL.appendingPathComponent(fileName)

        do {
            try fileManager.moveItem(at: sourceURL, to: destinationURL)
            return fileName
        } catch {
            print("Failed to save recording: \(error)")
            return nil
        }
    }
}
