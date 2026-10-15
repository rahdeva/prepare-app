import SwiftUI

struct HistoryDetailView: View {
    let session: PracticeSession

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

                if session.rating > 0 {
                    DetailRatingCard(rating: session.rating)
                        .padding(.top, 4)
                }

                if !session.notes.isEmpty {
                    DetailNotesCard(notes: session.notes)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
        .background(Color.slate50)
        .localizedNavigationTitle("History Detail")
        .navigationBarTitleDisplayMode(.inline)
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
}
