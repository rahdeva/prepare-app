//
//  PracticeStatsUtil.swift
//  PREPare
//

import Foundation

/// Streak and per-day activity derived from the dates of saved practice sessions.
struct PracticeStats {
    let calendar: Calendar
    /// Number of sessions per day, keyed by the start of that day.
    let dailyCounts: [Date: Int]
    /// Consecutive practice days ending today, or ending yesterday when today's session hasn't happened yet.
    let currentStreak: Int
    let longestStreak: Int
    let hasPracticedToday: Bool

    var totalSessions: Int { dailyCounts.values.reduce(0, +) }

    init(dates: [Date], calendar: Calendar = .current, now: Date = Date()) {
        self.calendar = calendar

        var counts: [Date: Int] = [:]
        for date in dates {
            counts[calendar.startOfDay(for: date), default: 0] += 1
        }
        self.dailyCounts = counts

        let today = calendar.startOfDay(for: now)
        let practicedToday = counts[today] != nil
        self.hasPracticedToday = practicedToday

        // A streak is only broken once a full day has passed without practice, so a streak that
        // ended yesterday still counts until midnight.
        var streak = 0
        var day: Date? = practicedToday ? today : calendar.date(byAdding: .day, value: -1, to: today)
        while let current = day, counts[current] != nil {
            streak += 1
            day = calendar.date(byAdding: .day, value: -1, to: current)
        }
        self.currentStreak = streak

        var longest = 0
        var run = 0
        var previous: Date?
        for day in counts.keys.sorted() {
            if let previous,
               let next = calendar.date(byAdding: .day, value: 1, to: previous),
               calendar.isDate(next, inSameDayAs: day) {
                run += 1
            } else {
                run = 1
            }
            longest = max(longest, run)
            previous = day
        }
        self.longestStreak = longest
    }

    func count(on date: Date) -> Int {
        dailyCounts[calendar.startOfDay(for: date)] ?? 0
    }
}
