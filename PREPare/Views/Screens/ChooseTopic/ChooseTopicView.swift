//
//  ChooseTopicView.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI
// ChooseTopicView.swift
import SwiftUI

struct ChooseTopicView: View {
    @State private var topics: [Topic] = [
        Topic(
            id: "job-interview",
            title: "Job Interview",
            icon: "bubble.left.and.bubble.right",
            category: "CAREER",
            categoryOrder: 0
        ),
        Topic(id: "personal-strength", title: "Personal Strength", icon: "bubble.left.and.bubble.right", category: "CAREER", categoryOrder: 0),
        Topic(id: "career-goals", title: "Career Goals", icon: "bubble.left.and.bubble.right", category: "CAREER", categoryOrder: 0),
        Topic(id: "personal-growth", title: "Personal Growth", icon: "bubble.left.and.bubble.right", category: "PERSONAL GROWTH", categoryOrder: 1),
    ]
    @State private var selectedTopic: Topic? = nil
    
    var groupedTopics: [String: [Topic]] {
        Dictionary(grouping: topics, by: { $0.category })
    }
    
    var categories: [String] {
        groupedTopics.keys.sorted {
            let a = groupedTopics[$0]?.first?.categoryOrder ?? 0
            let b = groupedTopics[$1]?.first?.categoryOrder ?? 0
            return a < b
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(categories, id: \.self) { category in
                        Section(category) {
                            LazyVGrid(
                                columns: [GridItem(.flexible()), GridItem(.flexible())],
                                spacing: 16
                            ) {
                                ForEach(groupedTopics[category] ?? []) { topic in
                                    TopicCard(
                                        title: topic.title,
                                        icon: topic.icon,
                                        isSelected: selectedTopic?.id == topic.id
                                    )
                                    .onTapGesture { selectedTopic = topic }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            
            PrimaryButton(title: "Continue")
                .disabled(selectedTopic == nil)
                .padding()
        }
        .navigationTitle("Choose Topic")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AppView()
}
