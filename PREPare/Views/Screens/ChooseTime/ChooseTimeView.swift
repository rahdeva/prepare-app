
//
//  ChooseTopicView.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct ChooseTimeView: View {
    @Binding var path: NavigationPath
    
    @State private var selectedPrepTime: Int? = 30
    @State private var selectedTargetTime: Int? = 120
    
    let prepTimes = [0, 10, 20, 30, 60, 90, 120]
    let targetTimes = [60, 90, 120, 180, 300, 600, 900, 1200]
    
    var totalSeconds: Int {
        (selectedPrepTime ?? 0) + (selectedTargetTime ?? 0)
    }
    
    func formatTime(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        if m == 0 { return "\(s)s" }
        if s == 0 { return "\(m)m" }
        return "\(m)m \(s)s"
    }
    
    var body: some View {
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
                            ForEach(prepTimes, id: \.self) { time in
                                TimeChip(
                                    label: formatTime(time),
                                    isSelected: selectedPrepTime == time
                                )
                                .onTapGesture { selectedPrepTime = time }
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
                            ForEach(targetTimes, id: \.self) { time in
                                TimeChip(
                                    label: formatTime(time),
                                    isSelected: selectedTargetTime == time
                                )
                                .onTapGesture { selectedTargetTime = time }
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
                            Text(selectedPrepTime.map { formatTime($0) } ?? "-")
                                .foregroundStyle(.white)
                        }
                        
                        HStack {
                            Text("Speaking:")
                                .foregroundStyle(.white.opacity(0.8))
                            Spacer()
                            Text(selectedTargetTime.map { formatTime($0) } ?? "-")
                                .foregroundStyle(.white)
                        }
                        
                        Divider()
                            .background(.white.opacity(0.4))
                        
                        HStack {
                            Text("Total:")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                            Text(formatTime(totalSeconds))
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
            .disabled(selectedPrepTime == nil || selectedTargetTime == nil)
        }
        .navigationTitle("Choose Practice Time")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ChooseTimeView(path: .constant(NavigationPath()))
}
