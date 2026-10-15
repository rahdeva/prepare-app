//
//  PREPareUITests.swift
//  PREPareUITests
//
//  End-to-end checks of the main flows. Every launch uses `-UITesting`, which gives the app an
//  in-memory store and its own UserDefaults suite, so the simulator's real data is never touched.
//

import XCTest

final class PREPareUITests: XCTestCase {
    private var app: XCUIApplication!
    private let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
    }

    // MARK: - Helpers

    private func launch(skipOnboarding: Bool = true, seedHistory: Bool = false) {
        app.launchArguments = ["-UITesting"]
        if skipOnboarding { app.launchArguments.append("-UITestingSkipOnboarding") }
        if seedHistory { app.launchArguments.append("-UITestingSeedHistory") }
        app.launch()
    }

    /// Waits past the 2.5 s splash screen until Home is visible.
    private func waitForHome(file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(app.buttons["Start Practice"].waitForExistence(timeout: 10), "Home did not appear", file: file, line: line)
    }

    /// Accepts the microphone and speech recognition prompts if iOS shows them.
    private func allowSystemPermissionAlerts() {
        for _ in 0..<3 {
            let alert = springboard.alerts.firstMatch
            guard alert.waitForExistence(timeout: 3) else { return }
            for label in ["Allow", "OK", "Allow While Using App"] where alert.buttons[label].exists {
                alert.buttons[label].tap()
                break
            }
        }
    }

    private func tapWhenReady(_ element: XCUIElement, timeout: TimeInterval = 5, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertTrue(element.waitForExistence(timeout: timeout), "\(element) not found", file: file, line: line)
        element.tap()
    }

    private func scrollTo(_ element: XCUIElement, maxSwipes: Int = 8) {
        var swipes = 0
        while !element.isHittable && swipes < maxSwipes {
            app.swipeUp()
            swipes += 1
        }
    }

    private func element(_ identifierOrLabel: String) -> XCUIElement {
        app.descendants(matching: .any)[identifierOrLabel].firstMatch
    }

    /// Settings rows combine title and subtitle into one label, so match on the title prefix.
    private func settingRow(_ title: String) -> XCUIElement {
        app.buttons.matching(NSPredicate(format: "label BEGINSWITH %@", title)).firstMatch
    }

    /// Runs one practice session: topic, 0 s preparation, 3 min target, all four PREP steps.
    private func completePractice(topic: String = "Teamwork") {
        tapWhenReady(app.buttons["Start Practice"])
        allowSystemPermissionAlerts()

        tapWhenReady(app.staticTexts[topic])
        tapWhenReady(app.buttons["Continue"])

        tapWhenReady(app.staticTexts["0s"])
        tapWhenReady(app.staticTexts["3m"])
        tapWhenReady(app.buttons["Start"])

        tapWhenReady(app.buttons["Got It, I Understand!"])
        XCTAssertTrue(app.staticTexts["Ready to Practice?"].waitForExistence(timeout: 5), "Permissions were not granted")
        tapWhenReady(app.buttons["Start Practice"])

        for _ in 0..<3 {
            tapWhenReady(app.buttons["NEXT"])
        }
        tapWhenReady(app.buttons["FINISH"])
        XCTAssertTrue(app.staticTexts["Great Job!"].waitForExistence(timeout: 10), "Result screen did not appear")
    }

    // MARK: - Onboarding

    func testOnboardingNextThroughAllPages() {
        launch(skipOnboarding: false)
        tapWhenReady(app.buttons["Next"], timeout: 10)
        XCTAssertTrue(app.staticTexts["Time-Bound Practice"].waitForExistence(timeout: 3))
        tapWhenReady(app.buttons["Next"])
        XCTAssertTrue(app.staticTexts["Track Your Progress"].waitForExistence(timeout: 3))
        XCTAssertFalse(app.buttons["Skip"].exists, "Skip should hide on the last page")
        tapWhenReady(app.buttons["Get Started"])
        waitForHome()
    }

    func testOnboardingSkipJumpsToLastPage() {
        launch(skipOnboarding: false)
        tapWhenReady(app.buttons["Skip"], timeout: 10)
        tapWhenReady(app.buttons["Get Started"])
        waitForHome()
    }

    // MARK: - Home

    func testHomeEmptyState() {
        launch()
        waitForHome()
        XCTAssertTrue(app.staticTexts["Practice today to start a new streak"].exists)
        XCTAssertTrue(app.staticTexts["My History"].exists)
    }

    func testPREPFrameworkSheetOpens() {
        launch()
        waitForHome()
        tapWhenReady(app.buttons["PREP"])
        XCTAssertTrue(app.staticTexts["State your main opinion."].waitForExistence(timeout: 5))
    }

    // MARK: - Practice flow

    func testChooseTopicRequiresSelection() {
        launch()
        waitForHome()
        tapWhenReady(app.buttons["Start Practice"])
        allowSystemPermissionAlerts()
        XCTAssertTrue(app.buttons["Continue"].waitForExistence(timeout: 5))
        XCTAssertFalse(app.buttons["Continue"].isEnabled)
        tapWhenReady(app.staticTexts["Leadership"])
        XCTAssertTrue(app.buttons["Continue"].isEnabled)
    }

    func testChooseTimeShowsTotal() {
        launch()
        waitForHome()
        tapWhenReady(app.buttons["Start Practice"])
        allowSystemPermissionAlerts()
        tapWhenReady(app.staticTexts["Teamwork"])
        tapWhenReady(app.buttons["Continue"])

        // Default is 30 s + 2 min.
        XCTAssertTrue(app.staticTexts["2m 30s"].waitForExistence(timeout: 5))
        tapWhenReady(app.staticTexts["10s"])
        tapWhenReady(app.staticTexts["5m"])
        XCTAssertTrue(app.staticTexts["5m 10s"].waitForExistence(timeout: 3))
    }

    func testPreparationCanBeSkipped() {
        launch()
        waitForHome()
        tapWhenReady(app.buttons["Start Practice"])
        allowSystemPermissionAlerts()
        tapWhenReady(app.staticTexts["Teamwork"])
        tapWhenReady(app.buttons["Continue"])
        tapWhenReady(app.buttons["Start"])
        tapWhenReady(app.buttons["Got It, I Understand!"])
        tapWhenReady(app.buttons["Start Practice"])

        XCTAssertTrue(app.staticTexts["Think about your response"].waitForExistence(timeout: 5))
        tapWhenReady(app.buttons["Skip Preparation"])
        XCTAssertTrue(app.buttons["NEXT"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Point (P)"].exists)
    }

    func testFullPracticeIsSavedToHistory() {
        launch()
        waitForHome()
        completePractice(topic: "Teamwork")

        // The microphone recording was finalized and can be played back.
        XCTAssertTrue(app.staticTexts["Listen to your practice session"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Play"].isEnabled)

        let star = app.buttons["star_4"]
        scrollTo(star)
        star.tap()

        let notes = app.textFields["What went well? What can you improve?"]
        scrollTo(notes)
        notes.tap()
        notes.typeText("Clear point")

        let backHome = app.buttons["Back to Home"]
        scrollTo(backHome)
        backHome.tap()

        waitForHome()
        XCTAssertTrue(app.staticTexts["Practiced today. Keep it up!"].waitForExistence(timeout: 5))

        tapWhenReady(app.staticTexts["My History"])
        let card = app.staticTexts["Teamwork"]
        XCTAssertTrue(card.waitForExistence(timeout: 5))
        card.tap()

        XCTAssertTrue(app.staticTexts["History Detail"].waitForExistence(timeout: 5) || app.navigationBars["History Detail"].exists)
        XCTAssertTrue(app.staticTexts["Listen to your practice session"].waitForExistence(timeout: 5), "Recording should be saved with the session")
        XCTAssertTrue(app.buttons["Play"].isEnabled)

        let rating = element("Rating 4 of 5")
        scrollTo(rating)
        XCTAssertTrue(rating.exists, "Saved rating should be 4")
        XCTAssertTrue(app.staticTexts["Clear point"].exists || app.textViews["Clear point"].exists || app.textFields.containing(NSPredicate(format: "value == 'Clear point'")).count > 0)
    }

    func testPracticeAgainReturnsToChooseTopicWithTopicSelected() {
        launch()
        waitForHome()
        completePractice(topic: "Leadership")

        let again = app.buttons["Practice Again"]
        scrollTo(again)
        again.tap()

        XCTAssertTrue(app.buttons["Continue"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["Continue"].isEnabled, "Previous topic should stay selected")
        app.navigationBars.buttons.firstMatch.tap()
        waitForHome()
        XCTAssertTrue(app.staticTexts["Practiced today. Keep it up!"].exists, "Practice Again must also save")
    }

    func testResultIsSavedEvenIfAppIsClosedOnResultScreen() {
        launch()
        waitForHome()
        completePractice(topic: "Teamwork")

        let star = app.buttons["star_3"]
        scrollTo(star)
        star.tap()

        // Close the app from the result screen without pressing either button.
        XCUIDevice.shared.press(.home)
        app.terminate()

        app.launchArguments = ["-UITesting", "-UITestingKeepData"]
        app.launch()
        waitForHome()
        XCTAssertTrue(app.staticTexts["Practiced today. Keep it up!"].waitForExistence(timeout: 5))

        tapWhenReady(app.staticTexts["My History"])
        tapWhenReady(app.staticTexts["Teamwork"])
        let rating = element("Rating 3 of 5")
        scrollTo(rating)
        XCTAssertTrue(rating.exists, "Rating chosen on the result screen should be kept")
        XCTAssertTrue(app.buttons["Play"].isEnabled, "Recording should be kept")
    }

    func testResultButtonsDoNotSaveTwice() {
        launch()
        waitForHome()
        completePractice(topic: "Teamwork")

        let backHome = app.buttons["Back to Home"]
        scrollTo(backHome)
        backHome.tap()
        waitForHome()

        tapWhenReady(app.staticTexts["My History"])
        XCTAssertTrue(app.staticTexts["Teamwork"].waitForExistence(timeout: 5))
        XCTAssertEqual(app.staticTexts.matching(identifier: "Teamwork").count, 1)
    }

    // MARK: - History

    func testEmptyHistory() {
        launch()
        waitForHome()
        tapWhenReady(app.staticTexts["My History"])
        XCTAssertTrue(app.staticTexts["No Practice Sessions Yet"].waitForExistence(timeout: 5))
    }

    func testEditEvaluationInHistoryDetail() {
        launch(seedHistory: true)
        waitForHome()
        tapWhenReady(app.staticTexts["My History"])
        tapWhenReady(app.staticTexts["Job Interview"].firstMatch)

        let edit = app.buttons["Edit"]
        scrollTo(edit)
        edit.tap()
        tapWhenReady(app.buttons["star_2"])
        tapWhenReady(app.buttons["Save"])
        XCTAssertTrue(element("Rating 2 of 5").waitForExistence(timeout: 3))

        // Cancel discards changes.
        tapWhenReady(app.buttons["Edit"])
        tapWhenReady(app.buttons["star_5"])
        tapWhenReady(app.buttons["Cancel"])
        XCTAssertTrue(element("Rating 2 of 5").waitForExistence(timeout: 3))
    }

    // MARK: - Streak & activity

    func testSeededHistoryShowsStreakAndActivity() {
        launch(seedHistory: true)
        waitForHome()
        XCTAssertTrue(app.staticTexts["Practiced today. Keep it up!"].exists)

        tapWhenReady(app.staticTexts["day streak"])
        XCTAssertTrue(app.navigationBars["Practice Activity"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Tap a dot to see the details"].exists)
        // Sessions, current streak and best streak are all 3 for the seeded data.
        let threes = app.descendants(matching: .any).matching(NSPredicate(format: "label BEGINSWITH '3'"))
        XCTAssertGreaterThanOrEqual(threes.count, 3, app.debugDescription)
    }

    // MARK: - Settings

    func testDeleteAllHistory() {
        launch(seedHistory: true)
        waitForHome()
        tapWhenReady(app.buttons["Settings"])
        tapWhenReady(settingRow("Delete All History"))
        tapWhenReady(app.alerts.buttons["Delete"])
        app.navigationBars.buttons.firstMatch.tap()

        waitForHome()
        XCTAssertTrue(app.staticTexts["Practice today to start a new streak"].waitForExistence(timeout: 3))
        tapWhenReady(app.staticTexts["My History"])
        XCTAssertTrue(app.staticTexts["No Practice Sessions Yet"].waitForExistence(timeout: 5))
    }

    func testCancelDeleteKeepsHistory() {
        launch(seedHistory: true)
        waitForHome()
        tapWhenReady(app.buttons["Settings"])
        tapWhenReady(settingRow("Delete All History"))
        tapWhenReady(app.alerts.buttons["Cancel"])
        app.navigationBars.buttons.firstMatch.tap()
        waitForHome()
        XCTAssertTrue(app.staticTexts["Practiced today. Keep it up!"].exists)
    }

    func testSwitchLanguageToIndonesianAndBack() {
        launch()
        waitForHome()
        tapWhenReady(app.buttons["Settings"])
        tapWhenReady(app.buttons["Change Language"])
        tapWhenReady(app.buttons["🇮🇩  Bahasa Indonesia"])
        XCTAssertTrue(app.navigationBars["Pengaturan"].waitForExistence(timeout: 5))

        app.navigationBars.buttons.firstMatch.tap()
        XCTAssertTrue(app.buttons["Mulai Latihan"].waitForExistence(timeout: 5))

        tapWhenReady(app.buttons["Pengaturan"])
        tapWhenReady(app.buttons["Ganti Bahasa"])
        tapWhenReady(app.buttons["🇬🇧  English"])
        XCTAssertTrue(app.navigationBars["Settings"].waitForExistence(timeout: 5))
    }

    func testVersionIsShown() {
        launch()
        waitForHome()
        tapWhenReady(app.buttons["Settings"])
        let version = app.staticTexts["2.0.0"]
        scrollTo(version)
        XCTAssertTrue(version.exists, "Settings should show version 2.0.0")
    }

    func testDailyReminderToggleShowsTimeRow() {
        launch()
        waitForHome()
        tapWhenReady(app.buttons["Settings"])
        XCTAssertFalse(app.staticTexts["Reminder Time"].exists)

        tapWhenReady(app.switches.firstMatch)
        allowSystemPermissionAlerts()
        XCTAssertTrue(app.staticTexts["Reminder Time"].waitForExistence(timeout: 5))

        tapWhenReady(app.switches.firstMatch)
        XCTAssertTrue(app.staticTexts["Reminder Time"].waitForNonExistence(timeout: 5))
    }
}
