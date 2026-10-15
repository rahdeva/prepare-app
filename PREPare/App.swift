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
        // SwiftData stores its database in Application Support, which doesn't exist on a fresh
        // install. Creating it first avoids CoreData's failed-then-recovered store errors.
        if let supportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            try? FileManager.default.createDirectory(at: supportURL, withIntermediateDirectories: true)
        }

        let launchOptions = UITestingLaunchOptions.current
        let schema = Schema([PracticeSession.self])
        let modelConfiguration = launchOptions.modelConfiguration(schema: schema)
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            launchOptions.prepare(container.mainContext)
            self.sharedModelContainer = container
            self._generalVM = State(initialValue: GeneralViewModel(
                modelContext: container.mainContext,
                defaults: launchOptions.defaults
            ))
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
                .environment(\.locale, generalVM.selectedLanguage.locale)
                .appColorScheme()
                .task { generalVM.syncDailyReminder() }
        }
        .modelContainer(sharedModelContainer)
    }
}
