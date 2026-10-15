//
//  PREPStepModel.swift
//  PREPare
//

import SwiftUI

/// The four steps of the PREP framework. All user-facing text lives in
/// Localizable.xcstrings; the letters are part of the framework name and stay as-is.
enum PREPStep: Int, CaseIterable, Identifiable {
    case point
    case reason
    case example
    case restate

    var id: Int { rawValue }

    var number: Int { rawValue + 1 }

    var letter: String {
        switch self {
            case .point, .restate: "P"
            case .reason: "R"
            case .example: "E"
        }
    }

    var title: LocalizedStringKey {
        switch self {
            case .point: "Point"
            case .reason: "Reason"
            case .example: "Example"
            case .restate: "Point (Restate)"
        }
    }

    /// Label shown under the progress bar while practicing.
    var practiceLabel: LocalizedStringKey {
        switch self {
            case .point: "Point (P)"
            case .reason: "Reason (R)"
            case .example: "Example (E)"
            case .restate: "Restate Point (P)"
        }
    }

    // MARK: - PREP Guide screen

    var guideSubtitle: LocalizedStringKey {
        switch self {
            case .point: "State your main idea clearly"
            case .reason: "Explain why this matters"
            case .example: "Give a concrete example"
            case .restate: "Reinforce your main idea"
        }
    }

    var guideExample: LocalizedStringKey {
        switch self {
            case .point: "“I am passionate about web development.”"
            case .reason: "“Because it allows me to create solutions that help people.”"
            case .example: "“For instance, I built an app that helps students organize their schedules.”"
            case .restate: "“That's why web development is my passion.”"
        }
    }

    // MARK: - PREP Framework sheet

    var sheetDescription: LocalizedStringKey {
        switch self {
            case .point: "State your main opinion."
            case .reason: "Explain the reason behind your opinion."
            case .example: "Give a simple example."
            case .restate: "Repeat your main opinion as a closing."
        }
    }

    var sheetExample: LocalizedStringKey {
        switch self {
            case .point: "I think morning exercise is important."
            case .reason: "Because exercise can make the body healthier and more refreshed."
            case .example: "For example, when I go jogging in the morning, I feel more focused while working."
            case .restate: "So, I believe morning exercise is very beneficial."
        }
    }

    // MARK: - Result guidelines

    var guidelines: [LocalizedStringKey] {
        switch self {
            case .point: [
                "Clear and concise main statement",
                "Easy to understand and remember",
                "Directly answers the question or topic",
                "Sets the direction for your entire response",
            ]
            case .reason: [
                "Explains the “why” behind your point",
                "Provides logical justification",
                "Connects to broader context or impact",
                "Makes your argument more convincing",
            ]
            case .example: [
                "Specific, concrete illustration",
                "Real-world scenario or case study",
                "Makes your point relatable and memorable",
                "Provides evidence to support your claim",
            ]
            case .restate: [
                "Reinforces your main message",
                "Provides a strong conclusion",
                "May be slightly rephrased for impact",
                "Leaves a lasting impression on your audience",
            ]
        }
    }
}
