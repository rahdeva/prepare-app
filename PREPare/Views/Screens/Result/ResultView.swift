import SwiftUI
import SwiftData

struct ResultView: View {
    @Binding var path: NavigationPath
    @Environment(PracticeViewModel.self) private var practiceVM
    @Environment(HistoryViewModel.self) private var historyVM

    @Environment(\.scenePhase) private var scenePhase

    @State private var rating: Int = 0
    @State private var notes: String = ""
    @State private var expandedSteps: Set<Int> = []
    /// Set as soon as the screen appears, so the practice is kept even if the app is closed here.
    @State private var savedSession: PracticeSession?

    private var totalTimeSeconds: Int { practiceVM.totalPracticeTime }
    private var targetTimeSeconds: Int { practiceVM.selectedTargetTime ?? 120 }

    private var prepStepResults: [PREPStepResult] {
        PREPStep.allCases.map { step in
            PREPStepResult(
                step: step,
                timeSeconds: practiceVM.stepDurations[step.rawValue],
                transcription: practiceVM.stepTranscriptions[step.rawValue]
            )
        }
    }

    /// Saves the finished practice once, when the result screen first appears.
    private func saveSessionIfNeeded() {
        guard savedSession == nil else { return }
        savedSession = historyVM.saveSession(
            topicTitle: practiceVM.selectedTopic?.title ?? "Unknown Topic", // English key, localized on display
            questionText: practiceVM.selectedQuestion?.text ?? "",
            totalTimeSeconds: totalTimeSeconds,
            targetTimeSeconds: targetTimeSeconds,
            rating: rating,
            notes: notes,
            stepTranscriptions: practiceVM.stepTranscriptions,
            stepDurations: practiceVM.stepDurations,
            recordingURL: practiceVM.audioRecorder.recordingURL
        )
    }

    /// Writes the current rating and notes to the already saved session.
    private func saveEvaluation() {
        guard let savedSession else { return }
        historyVM.updateEvaluation(of: savedSession, rating: rating, notes: notes)
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 24) {
                    ResultHeader()

                    TimeSummaryCard(
                        totalTimeSeconds: totalTimeSeconds,
                        targetTimeSeconds: targetTimeSeconds
                    )

                    // Saving moves the recording into Documents, so play it from the saved session.
                    RecordingResultCard(
                        totalDurationSeconds: totalTimeSeconds,
                        recordingURL: savedSession?.recordingURL
                    )

                    PREPSummarySection(
                        prepStepResults: prepStepResults,
                        expandedSteps: $expandedSteps
                    )

                    SelfEvaluationSection(
                        rating: $rating,
                        notes: $notes
                    )
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 24)

                ResultBottomButtons(
                    path: $path,
                    onSave: saveEvaluation,
                    onPracticeAgain: practiceVM.prepareForPracticeAgain
                )
            }
        }
        .onAppear(perform: saveSessionIfNeeded)
        .onChange(of: rating) { saveEvaluation() }
        // Notes are saved when leaving rather than on every keystroke.
        .onChange(of: scenePhase) { _, phase in
            if phase != .active { saveEvaluation() }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .overlay(Confetti())
        .localizedNavigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ResultView(path: .constant(NavigationPath()))
            .environment(PracticeViewModel())
            .environment(HistoryViewModel(modelContext: PreviewContainer.context))
    }
}
