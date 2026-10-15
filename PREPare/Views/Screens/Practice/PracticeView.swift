import SwiftUI

enum PracticeState {
    case preparation
    case practice
}

struct PracticeView: View {
    @Binding var path: NavigationPath
    @Environment(PracticeViewModel.self) private var practiceVM

    var topic: String { practiceVM.selectedTopic?.title ?? TopicData.topics[0].title }
    var question: String { practiceVM.selectedQuestion?.text ?? TopicData.questions[0].text }
    var prepSeconds: Int { practiceVM.selectedPrepTime ?? 30 }
    var targetSeconds: Int { practiceVM.selectedTargetTime ?? 120 }

    @State private var practiceState: PracticeState = .preparation
    @State private var timeRemaining: Int = 30
    @State private var timeElapsed: Int = 0
    @State private var timer: Timer? = nil
    @State private var currentPREPIndex: Int = 0
    /// 0 = empty, 1 = full. Animated once, linearly, over the whole preparation time.
    @State private var prepFillProgress: CGFloat = 0

    func startTimer() {
        if prepSeconds <= 0 {
            switchToPractice()
            return
        }

        // Drive both the countdown and the fill from the same start date so they can't drift apart.
        let startDate = Date()
        let duration = TimeInterval(prepSeconds)
        timeRemaining = prepSeconds
        prepFillProgress = 0
        withAnimation(.linear(duration: duration)) {
            prepFillProgress = 1
        }

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            let remaining = duration - Date().timeIntervalSince(startDate)
            if remaining <= 0 {
                switchToPractice()
            } else {
                let seconds = Int(remaining.rounded(.up))
                if seconds != timeRemaining { timeRemaining = seconds }
            }
        }
    }

    func switchToPractice() {
        timer?.invalidate()
        timer = nil
        withAnimation(.easeInOut(duration: 0.3)) {
            practiceState = .practice
            timeRemaining = targetSeconds
            timeElapsed = 0
        }
        practiceVM.startRecordingSession()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            timeElapsed += 1
        }
    }

    func nextPREPStep() {
        if currentPREPIndex < PREPStep.allCases.count - 1 {
            practiceVM.advanceStep(currentIndex: currentPREPIndex)
            withAnimation { currentPREPIndex += 1 }
        } else {
            timer?.invalidate()
            timer = nil
            practiceVM.finishSession(currentIndex: currentPREPIndex, totalTime: timeElapsed)
            path.append(AppRoute.result)
        }
    }

    var body: some View {
        GeometryReader { _ in
            ZStack() {
                LinearGradient.primaryGradient.ignoresSafeArea()

                if practiceState == .preparation && prepSeconds > 0 {
                    // Full-screen layer scaled from the bottom: reaches the very top exactly when time runs out.
                    Color.successColor.opacity(0.5)
                        .scaleEffect(x: 1, y: prepFillProgress, anchor: .bottom)
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                }

                VStack(spacing: 0) {
                    QuestionCard(topic: topic, question: question)
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    Spacer()

                    if practiceState == .preparation {
                        PreparationMiddleContent(timeRemaining: timeRemaining)
                    } else {
                        PracticeMiddleContent(currentPREPIndex: currentPREPIndex)
                    }

                    Spacer()

                    if practiceState == .preparation {
                        PreparationBottomContent(
                            onSkip: { switchToPractice() }
                        )
                        .padding(.bottom, 24)
                    } else {
                        PracticeBottomContent(
                            timeElapsed: timeElapsed,
                            targetSeconds: targetSeconds,
                            onNext: { nextPREPStep() },
                            isLast: currentPREPIndex == PREPStep.allCases.count - 1
                        )
                        .padding(.bottom, 24)
                    }
                }
            }
            .localizedNavigationTitle("Practice")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .onAppear { startTimer() }
            .onDisappear {
                timer?.invalidate()
                timer = nil
                if practiceVM.audioRecorder.isRecording {
                    practiceVM.audioRecorder.stopRecording()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PracticeView(path: .constant(NavigationPath()))
            .environment(PracticeViewModel())
    }
}
