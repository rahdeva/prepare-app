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

    private let stepLetters = ["P", "R", "E", "P"]
    private let stepTitles = ["Point", "Reason", "Example", "Point (Restate)"]
    private let stepGuidelines: [[String]] = [
        [
            "Clear and concise main statement",
            "Easy to understand and remember",
            "Directly answers the question or topic",
            "Sets the direction for your entire response"
        ],
        [
            "Explains the \"why\" behind your point",
            "Provides logical justification",
            "Connects to broader context or impact",
            "Makes your argument more convincing"
        ],
        [
            "Specific, concrete illustration",
            "Real-world scenario or case study",
            "Makes your point relatable and memorable",
            "Provides evidence to support your claim"
        ],
        [
            "Reinforces your main message",
            "Provides a strong conclusion",
            "May be slightly rephrased for impact",
            "Leaves a lasting impression on your audience"
        ]
    ]

    private var prepStepResults: [PREPStepResult] {
        (0..<4).map { index in
            PREPStepResult(
                letter: stepLetters[index],
                title: stepTitles[index],
                stepNumber: index + 1,
                totalSteps: 4,
                timeSeconds: practiceVM.stepDurations[index],
                stepResult: practiceVM.stepTranscriptions[index].isEmpty
                    ? "No speech detected"
                    : practiceVM.stepTranscriptions[index],
                guidelines: stepGuidelines[index]
            )
        }
    }

    private func saveSession() {
        historyVM.saveSession(
            topicTitle: practiceVM.selectedTopic?.title ?? "Unknown Topic",
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
        .navigationTitle("Result")
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
