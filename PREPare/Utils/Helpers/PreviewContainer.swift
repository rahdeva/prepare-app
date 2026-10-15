//
//  PreviewContainer.swift
//  PREPare
//

import SwiftData

/// In-memory SwiftData container for SwiftUI previews.
///
/// Held in a static so it lives for the whole preview process. A container created inline, such as
/// `try! ModelContainer(...).mainContext`, is released straight away and leaves the context without
/// a store, which crashes the preview on the first fetch. It also registers `PracticeSession`,
/// because `HistoryViewModel` fetches sessions as soon as it is created.
enum PreviewContainer {
    static let shared: ModelContainer = {
        do {
            return try ModelContainer(
                for: PracticeSession.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
        } catch {
            fatalError("Could not create preview ModelContainer: \(error)")
        }
    }()

    static var context: ModelContext { shared.mainContext }
}
