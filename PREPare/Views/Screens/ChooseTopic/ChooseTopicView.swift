//
//  ChooseTopicView.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct ChooseTopicView: View {
    @Binding var path: NavigationPath
    @State private var selectedTopic: String? = nil

    let topics: [String: [String]] = [
        "CAREER": ["Job Interview", "Teamwork", "Career Goals"],
        "PERSONAL GROWTH": ["Personal Growth"]
    ]

    let categoryOrder = ["CAREER", "PERSONAL GROWTH"]

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(categoryOrder, id: \.self) { category in
                        Section(category) {
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible(), spacing: 16),
                                    GridItem(.flexible())
                                ],
                                spacing: 16,
                            ) {
                                ForEach(topics[category] ?? [], id: \.self) { title in
                                    TopicCard(
                                        title: title,
                                        isSelected: selectedTopic == title
                                    )
                                    .onTapGesture { selectedTopic = title }
                                }
                            }
                        }
                        .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal, 24)
            }

            PrimaryButton(
                title: "Continue",
                action: {
                    path.append(AppRoute.chooseTime)
                }
            )
                .disabled(selectedTopic == nil)
        }
        .navigationTitle("Choose Topic")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    ChooseTopicView(path: .constant(NavigationPath()))
}
