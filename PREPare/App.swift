//
//  PREPareApp.swift
//  PREPare
//
//  Created by rahdeva on 20/04/26.
//

import SwiftUI
import SwiftData

@main
struct PREPareApp: App {
    let sharedModelContainer: ModelContainer
    @State private var generalVM: GeneralViewModel
    @State private var practiceVM = PracticeViewModel()
    @State private var historyVM: HistoryViewModel

    init() {
        let schema = Schema([PracticeSession.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            self.sharedModelContainer = container
            self._generalVM = State(initialValue: GeneralViewModel(modelContext: container.mainContext))
            self._historyVM = State(initialValue: HistoryViewModel(modelContext: container.mainContext))
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(generalVM)
                .environment(practiceVM)
                .environment(historyVM)
                .preferredColorScheme(.light)
        }
        .modelContainer(sharedModelContainer)
    }
}
