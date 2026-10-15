import SwiftUI
import SwiftData

struct ResultView: View {
    @Binding var path: NavigationPath
    @Environment(PracticeViewModel.self) private var practiceVM
    @Environment(HistoryViewModel.self) private var historyVM

    @State private var rating: Int = 0
    @State private var notes: String = ""
    @State private var expandedSteps: Set<Int> = []

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

    private func saveSession() {
        historyVM.saveSession(
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

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 24) {
                    ResultHeader()

                    TimeSummaryCard(
                        totalTimeSeconds: totalTimeSeconds,
                        targetTimeSeconds: targetTimeSeconds
                    )

                    RecordingResultCard(
                        totalDurationSeconds: totalTimeSeconds,
                        recordingURL: practiceVM.audioRecorder.recordingURL
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
                    onSave: saveSession
                )
            }
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
            .environment(HistoryViewModel(modelContext: try! ModelContainer(configurations: ModelConfiguration(isStoredInMemoryOnly: true)).mainContext))
    }
}
