//
//  ChooseTopicView.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct ChooseTopicView: View {
    @Binding var path: NavigationPath
    @Environment(PracticeViewModel.self) private var practiceVM

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(practiceVM.groupedTopics, id: \.category) { group in
                        Section(group.category) {
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible(), spacing: 16),
                                    GridItem(.flexible())
                                ],
                                spacing: 16,
                            ) {
                                ForEach(group.topics) { topic in
                                    TopicCard(
                                        topic: topic,
                                        isSelected: practiceVM.selectedTopic == topic
                                    )
                                    .onTapGesture { practiceVM.selectedTopic = topic }
                                }
                            }
                        }
                        .fontWeight(.semibold)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
            }

            PrimaryButton(
                title: "Continue",
                action: {
                    path.append(AppRoute.chooseTime)
                },
                isDisabled: practiceVM.selectedTopic == nil
            )
        }
        .navigationTitle("Choose Topic")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    ChooseTopicView(path: .constant(NavigationPath()))
        .environment(PracticeViewModel())
}
