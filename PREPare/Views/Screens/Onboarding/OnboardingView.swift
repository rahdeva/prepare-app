//
//  OnboardingView.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Circle()
                    .fill(.white.opacity(0.15))
                    .frame(width: 100, height: 100)
                    .offset(x: 60, y: -60)
            }
            Spacer()
        }
        
        VStack {
            Spacer()
            HStack {
                Circle()
                    .fill(.white.opacity(0.15))
                    .frame(width: 100, height: 100)
                    .offset(x: -60, y: 60)
                Spacer()
            }
        }
    }
}
