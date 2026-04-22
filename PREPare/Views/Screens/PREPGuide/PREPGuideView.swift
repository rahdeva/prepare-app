//
//  PREPGuideView.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct PREPGuideView: View {
    @Binding var path: NavigationPath
    
    let steps: [(letter: String, title: String, subtitle: String, example: String)] = [
        (letter: "P", title: "Point", subtitle: "State your main idea clearly", example: "\"I am passionate about web development\""),
        (letter: "R", title: "Reason", subtitle: "Explain why this matters", example: "\"Because it allows me to create solutions that help people\""),
        (letter: "E", title: "Example", subtitle: "Give a concrete example", example: "\"For instance, I built an app that helps students organize their schedules\""),
        (letter: "P", title: "Point (Restate)", subtitle: "Reinforce your main idea", example: "\"That's why web development is my passion\""),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "lightbulb.fill")
                            .foregroundStyle(Color.yellow500)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Quick Guide")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.yellow700)
                            
                            Text("Use this framework to organize your thoughts before speaking. Each step builds on the previous one.")
                                .font(.subheadline)
                                .foregroundStyle(Color.yellow700)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.yellow100)
                    .cornerRadius(12)
                    .shadowPrimary()
                    
                    ForEach(steps, id: \.title) { step in
                        PointStepCard(step: step)
                    }
                }
                .padding(24)
            }
            
            PrimaryButton(
                title: "Got It! I'm understand.",
                action: {
                    path.append(AppRoute.practice)
                }
            )
        }
        .navigationTitle("PREP Framework")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PREPGuideView(path: .constant(NavigationPath()))
    }
}
