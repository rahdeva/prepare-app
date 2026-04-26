//
//  ContentView.swift
//  PREPare
//
//  Created by rahdeva on 20/04/26.
//

import SwiftUI
import SwiftData

struct AppView: View {
    @State private var isSplashPresented: Bool = true
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if !isSplashPresented {
//                    OnboardingView()
                    HomeView(path: $path)
                } else {
                    SplashView(isPresented: $isSplashPresented)
                }
            }
            .registerRoutes(path: $path)
        }
    }
}

#Preview {
    AppView()
        .modelContainer(for: Item.self, inMemory: true)
    
}
