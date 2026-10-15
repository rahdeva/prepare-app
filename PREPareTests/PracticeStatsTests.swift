//
//  PracticeStatsTests.swift
//  PREPareTests
//

import Foundation
import Testing
@testable import PREPare

@MainActor
struct PracticeStatsTests {
    let calendar = makeUTCCalendar()
    let now = makeDate(2026, 10, 15, hour: 18)

    private func stats(daysAgo: [Int], hour: Int = 9) -> PracticeStats {
        let dates = daysAgo.map { offset in
            calendar.date(byAdding: .day, value: -offset, to: makeDate(2026, 10, 15, hour: hour))!
        }
        return PracticeStats(dates: dates, calendar: calendar, now: now)
    }

    @Test func emptyHistoryHasNoStreak() {
        let stats = stats(daysAgo: [])
        #expect(stats.currentStreak == 0)
        #expect(stats.longestStreak == 0)
        #expect(stats.totalSessions == 0)
        #expect(stats.hasPracticedToday == false)
    }

    @Test func practicingTodayStartsAStreak() {
        let stats = stats(daysAgo: [0])
        #expect(stats.currentStreak == 1)
        #expect(stats.hasPracticedToday)
    }

    @Test func consecutiveDaysEndingTodayAreCounted() {
        let stats = stats(daysAgo: [0, 1, 2, 3])
        #expect(stats.currentStreak == 4)
        #expect(stats.longestStreak == 4)
    }

    @Test func streakEndingYesterdayIsStillAlive() {
        let stats = stats(daysAgo: [1, 2, 3])
        #expect(stats.currentStreak == 3)
        #expect(stats.hasPracticedToday == false)
    }

    @Test func missingAFullDayBreaksTheStreak() {
        let stats = stats(daysAgo: [2, 3, 4])
        #expect(stats.currentStreak == 0)
        #expect(stats.longestStreak == 3)
    }

    @Test func gapInHistoryOnlyCountsTheRecentRun() {
        let stats = stats(daysAgo: [0, 1, 3, 4, 5, 6, 7])
        #expect(stats.currentStreak == 2)
        #expect(stats.longestStreak == 5)
    }

    @Test func severalSessionsOnOneDayCountAsOneStreakDay() {
        let stats = stats(daysAgo: [0, 0, 0, 1])
        #expect(stats.currentStreak == 2)
        #expect(stats.totalSessions == 4)
        #expect(stats.count(on: now) == 3)
    }

    @Test func countIgnoresTimeOfDay() {
        let stats = stats(daysAgo: [0, 0])
        #expect(stats.count(on: makeDate(2026, 10, 15, hour: 0)) == 2)
        #expect(stats.count(on: makeDate(2026, 10, 15, hour: 23)) == 2)
        #expect(stats.count(on: makeDate(2026, 10, 14)) == 0)
    }

    @Test func sessionLateLastNightAndEarlyTodayAreTwoDays() {
        let dates = [
            calendar.date(from: DateComponents(year: 2026, month: 10, day: 14, hour: 23, minute: 59))!,
            calendar.date(from: DateComponents(year: 2026, month: 10, day: 15, hour: 0, minute: 1))!,
        ]
        let stats = PracticeStats(dates: dates, calendar: calendar, now: now)
        #expect(stats.currentStreak == 2)
        #expect(stats.dailyCounts.count == 2)
    }

    @Test func streakSpansMonthAndYearBoundaries() {
        let dates = [makeDate(2025, 12, 30), makeDate(2025, 12, 31), makeDate(2026, 1, 1), makeDate(2026, 1, 2)]
        let stats = PracticeStats(dates: dates, calendar: calendar, now: makeDate(2026, 1, 2, hour: 20))
        #expect(stats.currentStreak == 4)
        #expect(stats.longestStreak == 4)
    }

    @Test func leapDayIsPartOfTheStreak() {
        let dates = [makeDate(2028, 2, 28), makeDate(2028, 2, 29), makeDate(2028, 3, 1)]
        let stats = PracticeStats(dates: dates, calendar: calendar, now: makeDate(2028, 3, 1))
        #expect(stats.currentStreak == 3)
    }

    @Test func unsortedDatesGiveTheSameResult() {
        let ordered = stats(daysAgo: [0, 1, 2, 5, 6])
        let shuffled = stats(daysAgo: [5, 0, 6, 2, 1])
        #expect(ordered.currentStreak == shuffled.currentStreak)
        #expect(ordered.longestStreak == shuffled.longestStreak)
    }

    @Test func streakAcrossDaylightSavingChange() {
        // Europe/Berlin moves clocks back on 25 Oct 2026, which makes that day 25 hours long.
        var berlin = Calendar(identifier: .gregorian)
        berlin.timeZone = TimeZone(identifier: "Europe/Berlin")!
        let dates = (24...27).map { makeDate(2026, 10, $0, hour: 10, calendar: berlin) }
        let stats = PracticeStats(dates: dates, calendar: berlin, now: makeDate(2026, 10, 27, hour: 22, calendar: berlin))
        #expect(stats.currentStreak == 4)
        #expect(stats.longestStreak == 4)
    }
}
