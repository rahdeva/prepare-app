//
//  AppRouter.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct AppRouter: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                    case .settings:
                        SettingView()
                        
                    case .history:
                        HistoryView()
                    
                    case .chooseTopic:
                        ChooseTopicView()
                }
            }
    }
}

extension View {
    func registerRoutes() -> some View {
        self.modifier(AppRouter())
    }
}
