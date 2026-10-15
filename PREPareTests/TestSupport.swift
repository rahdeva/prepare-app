//
//  TestSupport.swift
//  PREPareTests
//

import Foundation
import SwiftData
@testable import PREPare

/// In-memory SwiftData store plus an isolated `UserDefaults` suite, so tests never touch the
/// simulator's real app data. Keep the instance alive for the whole test: the context needs its container.
@MainActor
final class TestEnvironment {
    let container: ModelContainer
    let defaults: UserDefaults
    private let suiteName = "PREPareTests.\(UUID().uuidString)"

    var context: ModelContext { container.mainContext }

    init() throws {
        container = try ModelContainer(
            for: PracticeSession.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        defaults = UserDefaults(suiteName: suiteName)!
    }

    deinit {
        UserDefaults().removePersistentDomain(forName: suiteName)
    }

    func makeStorage() -> LocalStorageUtil {
        LocalStorageUtil(modelContext: context, defaults: defaults)
    }

    /// Writes a small file to the temporary directory, standing in for a finished recording.
    func makeTemporaryRecording(bytes: Int = 128, fileExtension: String = "m4a") throws -> URL {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension(fileExtension)
        try Data(repeating: 0xAB, count: bytes).write(to: url)
        return url
    }
}

/// Fixed Gregorian calendar in UTC so date math in tests doesn't depend on the machine's time zone.
func makeUTCCalendar() -> Calendar {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(identifier: "UTC")!
    return calendar
}

func makeDate(_ year: Int, _ month: Int, _ day: Int, hour: Int = 12, calendar: Calendar = makeUTCCalendar()) -> Date {
    calendar.date(from: DateComponents(year: year, month: month, day: day, hour: hour))!
}
