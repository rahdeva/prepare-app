//
//  HistoryViewModelTests.swift
//  PREPareTests
//

import Foundation
import SwiftData
import Testing
@testable import PREPare

@MainActor
struct HistoryViewModelTests {
    let env: TestEnvironment
    let viewModel: HistoryViewModel

    init() throws {
        env = try TestEnvironment()
        viewModel = HistoryViewModel(modelContext: env.context)
    }

    private func save(
        topic: String = "Job Interview",
        rating: Int = 3,
        notes: String = "",
        recordingURL: URL? = nil
    ) {
        viewModel.saveSession(
            topicTitle: topic,
            questionText: "Tell me about yourself.",
            totalTimeSeconds: 100,
            targetTimeSeconds: 120,
            rating: rating,
            notes: notes,
            stepTranscriptions: ["p", "r", "e", "p2"],
            stepDurations: [10, 20, 30, 40],
            recordingURL: recordingURL
        )
    }

    @Test func startsEmpty() {
        #expect(viewModel.sessions.isEmpty)
        #expect(viewModel.stats.totalSessions == 0)
    }

    @Test func savedSessionIsPersistedWithAllFields() throws {
        save(rating: 4, notes: "Good")

        #expect(viewModel.sessions.count == 1)
        let session = try #require(viewModel.sessions.first)
        #expect(session.topicTitle == "Job Interview")
        #expect(session.questionText == "Tell me about yourself.")
        #expect(session.totalTimeSeconds == 100)
        #expect(session.targetTimeSeconds == 120)
        #expect(session.rating == 4)
        #expect(session.notes == "Good")
        #expect(session.stepTranscriptions == ["p", "r", "e", "p2"])
        #expect(session.stepDurations == [10, 20, 30, 40])
        #expect(session.recordingFileName == nil)
        #expect(session.recordingURL == nil)

        // A fresh fetch from the store returns the same data.
        let stored = env.makeStorage().fetchAll(PracticeSession.self)
        #expect(stored.count == 1)
    }

    @Test func saveReturnsTheStoredSessionForLaterEvaluation() throws {
        let tempURL = try env.makeTemporaryRecording()
        let session = viewModel.saveSession(
            topicTitle: "Teamwork", questionText: "Q", totalTimeSeconds: 60, targetTimeSeconds: 60,
            rating: 0, notes: "", stepTranscriptions: [], stepDurations: [], recordingURL: tempURL
        )
        defer { session.recordingURL.map { try? FileManager.default.removeItem(at: $0) } }

        #expect(viewModel.sessions.first === session)
        let recordingURL = try #require(session.recordingURL)
        #expect(FileManager.default.fileExists(atPath: recordingURL.path))

        // The result screen rates the already saved session instead of inserting a second one.
        viewModel.updateEvaluation(of: session, rating: 5, notes: "Done")
        viewModel.updateEvaluation(of: session, rating: 5, notes: "Done")
        viewModel.fetchSessions()
        #expect(viewModel.sessions.count == 1)
        #expect(viewModel.sessions.first?.rating == 5)
    }

    @Test func sessionsAreNewestFirst() {
        save(topic: "First")
        save(topic: "Second")
        save(topic: "Third")
        #expect(viewModel.sessions.map(\.topicTitle) == ["Third", "Second", "First"])
    }

    @Test func statsFollowSavedSessions() {
        save()
        save()
        #expect(viewModel.stats.totalSessions == 2)
        #expect(viewModel.stats.hasPracticedToday)
        #expect(viewModel.stats.currentStreak == 1)
    }

    @Test func recordingIsMovedIntoDocuments() throws {
        let tempURL = try env.makeTemporaryRecording()
        save(recordingURL: tempURL)

        let session = try #require(viewModel.sessions.first)
        let fileName = try #require(session.recordingFileName)
        let savedURL = try #require(session.recordingURL)
        defer { try? FileManager.default.removeItem(at: savedURL) }

        #expect(fileName.hasSuffix(".m4a"))
        #expect(FileManager.default.fileExists(atPath: savedURL.path))
        #expect(FileManager.default.fileExists(atPath: tempURL.path) == false)

        let documents = try #require(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)
        #expect(savedURL.deletingLastPathComponent().standardizedFileURL == documents.standardizedFileURL)
    }

    @Test func emptyRecordingIsNotAttached() throws {
        let tempURL = try env.makeTemporaryRecording(bytes: 0)
        defer { try? FileManager.default.removeItem(at: tempURL) }
        save(recordingURL: tempURL)

        let session = try #require(viewModel.sessions.first)
        #expect(session.recordingFileName == nil)
    }

    @Test func missingRecordingStillSavesSession() throws {
        let missing = FileManager.default.temporaryDirectory.appendingPathComponent("\(UUID().uuidString).m4a")
        save(recordingURL: missing)

        #expect(viewModel.sessions.count == 1)
        #expect(viewModel.sessions.first?.recordingFileName == nil)
    }

    @Test func updateEvaluationTrimsNotes() throws {
        save(rating: 2, notes: "Old")
        let session = try #require(viewModel.sessions.first)

        viewModel.updateEvaluation(of: session, rating: 5, notes: "  Much better  \n")

        #expect(session.rating == 5)
        #expect(session.notes == "Much better")
        viewModel.fetchSessions()
        #expect(viewModel.sessions.first?.rating == 5)
    }

    @Test func updateEvaluationIgnoresWhitespaceOnlyChange() throws {
        save(rating: 3, notes: "Same")
        let session = try #require(viewModel.sessions.first)

        viewModel.updateEvaluation(of: session, rating: 3, notes: "Same   ")

        #expect(session.notes == "Same")
        #expect(env.context.hasChanges == false)
    }

    @Test func clearAllHistoryRemovesSessionsAndRecordings() throws {
        save(recordingURL: try env.makeTemporaryRecording())
        save(recordingURL: try env.makeTemporaryRecording())
        save()
        let recordingURLs = viewModel.sessions.compactMap(\.recordingURL)
        #expect(recordingURLs.count == 2)

        viewModel.clearAllHistory()

        #expect(viewModel.sessions.isEmpty)
        #expect(env.makeStorage().fetchCount(PracticeSession.self) == 0)
        for url in recordingURLs {
            #expect(FileManager.default.fileExists(atPath: url.path) == false)
        }

        // The store stays usable after a wipe.
        save()
        #expect(viewModel.sessions.count == 1)
    }
}
