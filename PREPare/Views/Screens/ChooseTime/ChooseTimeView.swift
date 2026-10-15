//
//  ChooseTimeView.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct ChooseTimeView: View {
    @Binding var path: NavigationPath
    @Environment(PracticeViewModel.self) private var practiceVM

    var body: some View {
        @Bindable var practiceVM = practiceVM

        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Preparation Time")
                            .font(.title3)
                            .fontWeight(.bold)

                        Text("Time to think before speaking")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 8)

                        LazyVGrid(
                            columns: Array(
                                repeating: GridItem(.flexible()),
                                count: 4
                            ),
                            spacing: 12
                        ) {
                            ForEach(practiceVM.prepTimes, id: \.self) { time in
                                TimeChip(
                                    seconds: time,
                                    isSelected: practiceVM.selectedPrepTime == time
                                )
                                .onTapGesture { practiceVM.selectedPrepTime = time }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Target Time")
                                    .font(.title3)
                                    .fontWeight(.bold)

                                Text("Speaking duration")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .padding(.bottom, 8)
                            }
                        }

                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible()), count: 4),
                            spacing: 12
                        ) {
                            ForEach(practiceVM.targetTimes, id: \.self) { time in
                                TimeChip(
                                    seconds: time,
                                    isSelected: practiceVM.selectedTargetTime == time
                                )
                                .onTapGesture { practiceVM.selectedTargetTime = time }
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your Practice Setup")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)

                        HStack {
                            Text("Preparation:")
                                .foregroundStyle(.white.opacity(0.8))
                            Spacer()
                            durationText(practiceVM.selectedPrepTime)
                                .foregroundStyle(.white)
                        }

                        HStack {
                            Text("Speaking:")
                                .foregroundStyle(.white.opacity(0.8))
                            Spacer()
                            durationText(practiceVM.selectedTargetTime)
                                .foregroundStyle(.white)
                        }

                        Divider()
                            .background(.white.opacity(0.4))

                        HStack {
                            Text("Total:")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                            Text(duration: practiceVM.totalSeconds)
                                .fontWeight(.bold)
                                .font(.title3)
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(20)
                    .background(Color.secondaryColor)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.primaryColor, lineWidth: 2)
                    )
                    .shadowPrimary()
                }
                .padding(24)
            }

            PrimaryButton(
                title: "Start",
                action: {
                    path.append(AppRoute.prepGuide)
                }
            )
            .disabled(practiceVM.selectedPrepTime == nil || practiceVM.selectedTargetTime == nil)
        }
        .localizedNavigationTitle("Choose Practice Time")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func durationText(_ seconds: Int?) -> Text {
        if let seconds {
            Text(duration: seconds)
        } else {
            Text(verbatim: "-")
        }
    }
}


#Preview {
    ChooseTimeView(path: .constant(NavigationPath()))
        .environment(PracticeViewModel())
}
