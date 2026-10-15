import SwiftUI
import SwiftData

struct HistoryDetailView: View {
    let session: PracticeSession

    @Environment(HistoryViewModel.self) private var historyVM
    @State private var rating: Int
    @State private var notes: String
    @State private var isEditing = false
    @FocusState private var isNotesFocused: Bool

    init(session: PracticeSession) {
        self.session = session
        _rating = State(initialValue: session.rating)
        _notes = State(initialValue: session.notes)
    }

    private func startEditing() {
        withAnimation(.easeInOut(duration: 0.2)) { isEditing = true }
    }

    private func cancelEditing() {
        isNotesFocused = false
        rating = session.rating
        notes = session.notes
        withAnimation(.easeInOut(duration: 0.2)) { isEditing = false }
    }

    private func saveEvaluation() {
        isNotesFocused = false
        historyVM.updateEvaluation(of: session, rating: rating, notes: notes)
        // Mirror the stored (trimmed) values so the read-only view matches what was saved.
        rating = session.rating
        notes = session.notes
        withAnimation(.easeInOut(duration: 0.2)) { isEditing = false }
    }

    private func duration(for step: PREPStep) -> Int {
        session.stepDurations.indices.contains(step.rawValue) ? session.stepDurations[step.rawValue] : 0
    }

    private func transcription(for step: PREPStep) -> String {
        session.stepTranscriptions.indices.contains(step.rawValue) ? session.stepTranscriptions[step.rawValue] : ""
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                DetailTopicCard(
                    topicName: session.topicTitle,
                    question: session.questionText,
                    date: session.date
                )

                DetailTimeCard(
                    totalTimeSeconds: session.totalTimeSeconds,
                    targetTimeSeconds: session.targetTimeSeconds
                )

                RecordingResultCard(
                    totalDurationSeconds: session.totalTimeSeconds,
                    recordingURL: session.recordingURL
                )

                Text("PREP Summary")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.slate900)
                    .padding(.top, 4)

                ForEach(PREPStep.allCases) { step in
                    DetailPREPStepCard(
                        step: step,
                        timeSeconds: duration(for: step),
                        transcription: transcription(for: step)
                    )
                }

                evaluationHeader
                    .padding(.top, 4)

                DetailRatingCard(rating: $rating, isEditing: isEditing)

                DetailNotesCard(notes: $notes, isEditing: isEditing, isFocused: $isNotesFocused)
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
        .scrollDismissesKeyboard(.interactively)
        .background(Color.slate50)
        .localizedNavigationTitle("History Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { isNotesFocused = false }
            }
        }
    }

    /// Section title with an Edit button, replaced by Cancel and Save while editing.
    private var evaluationHeader: some View {
        HStack {
            Text("Self-Evaluation")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(Color.slate900)

            Spacer()

            if isEditing {
                HStack(spacing: 8) {
                    Button(action: cancelEditing) {
                        Text("Cancel")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.slate700)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Capsule().fill(Color.slate100))
                    }

                    Button(action: saveEvaluation) {
                        Text("Save")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Capsule().fill(Color.primaryColor))
                    }
                }
            } else {
                Button(action: startEditing) {
                    Label("Edit", systemImage: "pencil")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.primaryColor)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Color.slate100))
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        HistoryDetailView(
            session: PracticeSession(
                topicTitle: "Job Interview",
                questionText: "Tell me about yourself.",
                totalTimeSeconds: 120,
                targetTimeSeconds: 150,
                rating: 4,
                notes: "Good flow, need to work on examples",
                stepTranscriptions: [
                    "My greatest weakness is that I tend to be overly detail-oriented.",
                    "This matters because in fast-paced environments, it can delay delivery.",
                    "For instance, I spent extra days refining an already-approved report.",
                    "So I've been actively working on setting time limits for quality and efficiency."
                ],
                stepDurations: [30, 30, 30, 30]
            )
        )
    }
    .environment(HistoryViewModel(modelContext: PreviewContainer.context))
}
