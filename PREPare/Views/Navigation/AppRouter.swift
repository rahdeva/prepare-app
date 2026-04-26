//
//  AppRouter.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct AppRouter: ViewModifier {
    @Binding var path: NavigationPath
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                    case .splash:
                        SplashView(isPresented: .constant(true))
                    
                    case .onboarding:
                        OnboardingView()
                    
                    case .home:
                        HomeView(path: $path)
                    
                    case .settings:
                        SettingView()
                        
                    case .history:
                        HistoryView(path: $path)
                    
                    case .historyDetail:
                        HistoryDetailView()
                    
                    case .chooseTopic:
                        ChooseTopicView(path: $path)
                    
                    case .chooseTime:
                        ChooseTimeView(path: $path)
                    
                    case .prepGuide:
                        PREPGuideView(path: $path)
                    
                    case .practice:
                        PracticeView(path: $path)
                    
                    case .result:
                        ResultView(path: $path)
                }
            }
    }
}

extension View {
    func registerRoutes(path: Binding<NavigationPath>) -> some View {
        self.modifier(AppRouter(path: path))
    }
}
