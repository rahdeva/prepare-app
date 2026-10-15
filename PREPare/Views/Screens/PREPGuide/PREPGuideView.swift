//
//  PREPGuideView.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct PREPGuideView: View {
    @Binding var path: NavigationPath
    @Environment(PracticeViewModel.self) private var practiceVM
    @State private var showConfirmation = false
    @State private var showPermissionAlert = false

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
                    
                    ForEach(PREPStep.allCases) { step in
                        PointStepCard(step: step)
                    }
                }
                .padding(24)
            }
            
            PrimaryButton(
                title: "Got It, I Understand!",
                action: {
                    if practiceVM.checkCurrentPermissions() {
                        showConfirmation = true
                    } else {
                        showPermissionAlert = true
                    }
                }
            )
        }
        .localizedNavigationTitle("PREP Framework")
        .navigationBarTitleDisplayMode(.inline)
        .overlay {
            if showConfirmation {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showConfirmation = false
                    }

                VStack(spacing: 16) {
                    HStack {
                        Spacer()
                        Button {
                            showConfirmation = false
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(Color.slate400)
                        }
                    }

                    ZStack {
                        Circle()
                            .fill(Color.primaryColor)
                            .frame(width: 56, height: 56)

                        Image(systemName: "exclamationmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundStyle(.white)
                    }

                    Text("Ready to Practice?")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.slate900)

                    Text("You'll have \(Text(duration: practiceVM.selectedPrepTime ?? 0)) of preparation time, then \(Text(duration: practiceVM.selectedTargetTime ?? 0)) to complete your response using the PREP framework.")
                        .font(.subheadline)
                        .foregroundStyle(Color.slate500)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)

                    HStack(spacing: 12) {
                        Button {
                            showConfirmation = false
                        } label: {
                            Text("Cancel")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Color.slate700)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(Color.slate100)
                                .cornerRadius(12)
                        }

                        Button {
                            showConfirmation = false
                            practiceVM.pickRandomQuestion()
                            path.append(AppRoute.practice)
                        } label: {
                            Text("Start Practice")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(Color.primaryColor)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.top, 4)
                }
                .padding(24)
                .background(.white)
                .cornerRadius(20)
                .shadowPrimary()
                .padding(.horizontal, 40)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showConfirmation)
        .alert("Permissions Required", isPresented: $showPermissionAlert) {
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Please enable Microphone and Speech Recognition access in Settings to start practice.")
        }
    }
}

#Preview {
    NavigationStack {
        PREPGuideView(path: .constant(NavigationPath()))
            .environment(PracticeViewModel())
    }
}
