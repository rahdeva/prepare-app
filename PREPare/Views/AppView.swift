//
//  ContentView.swift
//  PREPare
//
//  Created by rahdeva on 20/04/26.
//

import SwiftUI
import SwiftData

struct AppView: View {
    @Environment(GeneralViewModel.self) private var generalVM
    @State private var isSplashPresented: Bool = true
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if isSplashPresented {
                    SplashView(isPresented: $isSplashPresented)
                } else if !generalVM.hasCompletedOnboarding {
                    OnboardingView()
                } else {
                    HomeView(path: $path)
                }
            }
            .registerRoutes(path: $path)
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )
    AppView()
        .environment(GeneralViewModel(modelContext: container.mainContext))
        .modelContainer(container)
}
