import SwiftUI

enum PracticeState {
    case preparation
    case practice
}

struct PracticeView: View {
    @Binding var path: NavigationPath
    
    let topic = "Job Interview"
    let question = "What is your greatest weakness?"
    let prepSeconds = 30
    let targetSeconds = 120
    
    @State private var practiceState: PracticeState = .preparation
    @State private var timeRemaining: Int = 30
    @State private var timeElapsed: Int = 0
    @State private var timer: Timer? = nil
    @State private var currentPREPIndex: Int = 0
    
    let prepSteps = ["P", "R", "E", "P"]
    let prepStepNames = ["Point (P)", "Reason (R)", "Example (E)", "Point (P)"]
    
    var progress: CGFloat {
        CGFloat(prepSeconds - timeRemaining) / CGFloat(prepSeconds)
    }
    
    func startTimer() {
        timeRemaining = prepSeconds
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 { timeRemaining -= 1 }
            else { switchToPractice() }
        }
    }
    
    func switchToPractice() {
        timer?.invalidate()
        withAnimation(.easeInOut(duration: 0.3)) {
            practiceState = .practice
            timeRemaining = targetSeconds
            timeElapsed = 0
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timeElapsed += 1
        }
    }
    
    func nextPREPStep() {
        if currentPREPIndex < prepSteps.count - 1 {
            withAnimation { currentPREPIndex += 1 }
        } else {
            timer?.invalidate()
            path.append(AppRoute.result)
        }
    }
    
    func formatTime(_ seconds: Int) -> String {
        String(format: "%d:%02d", seconds / 60, seconds % 60)
    }
    
    var body: some View {
        GeometryReader{ geo in
            ZStack() {
                LinearGradient.primaryGradient.ignoresSafeArea()
                    .overlay(alignment: .bottom) {
                        if practiceState == .preparation {
                            Rectangle()
                                .fill(Color.successColor.opacity(0.5))
                                .ignoresSafeArea()
                                .frame(
                                    height: (geo.size.height + geo.safeAreaInsets.top) * progress
                                )
                                .animation(.linear(duration: 1), value: progress)
                        }
                    }
                
                VStack(spacing: 0) {
                    QuestionCard(topic: topic, question: question)
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                    
                    Spacer()
                    
                    if practiceState == .preparation {
                        PreparationMiddleContent(timeRemaining: timeRemaining)
                    } else {
                        PracticeMiddleContent(
                            prepSteps: prepSteps,
                            prepStepNames: prepStepNames,
                            currentPREPIndex: currentPREPIndex
                        )
                    }
                    
                    Spacer()
                    
                    if practiceState == .preparation {
                        PreparationBottomContent(
                            prepSeconds: prepSeconds,
                            progress: progress,
                            onSkip: { switchToPractice() }
                        )
                        .padding(.bottom, 24)
                    } else {
                        PracticeBottomContent(
                            timeElapsed: timeElapsed,
                            targetSeconds: targetSeconds,
                            formatTime: formatTime,
                            onNext: { nextPREPStep() },
                            isLast: currentPREPIndex == prepSteps.count - 1
                        )
                        .padding(.bottom, 24)
                    }
                }
            }
            .navigationTitle("Practice")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .onAppear { startTimer() }
            .onDisappear { timer?.invalidate() }
        }
    }
}

#Preview {
    NavigationStack {
        PracticeView(path: .constant(NavigationPath()))
    }
}
