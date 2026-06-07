import SwiftUI

struct HistoryDetailView: View {
    let session: PracticeSession

    private let stepLetters = ["P", "R", "E", "P"]
    private let stepTitles = ["Point", "Reason", "Example", "Point (Restate)"]

    private var prepSteps: [(letter: String, title: String, stepNumber: Int, timeSeconds: Int, resultText: String)] {
        (0..<4).map { index in
            (
                letter: stepLetters[index],
                title: stepTitles[index],
                stepNumber: index + 1,
                timeSeconds: session.stepDurations.indices.contains(index) ? session.stepDurations[index] : 0,
                resultText: session.stepTranscriptions.indices.contains(index) && !session.stepTranscriptions[index].isEmpty
                    ? session.stepTranscriptions[index]
                    : "No speech detected"
            )
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                DetailTopicCard(
                    topicName: session.topicTitle,
                    question: session.questionText,
                    date: session.formattedFullDate
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

                ForEach(prepSteps, id: \.stepNumber) { step in
                    DetailPREPStepCard(
                        letter: step.letter,
                        title: step.title,
                        stepNumber: step.stepNumber,
                        totalSteps: 4,
                        timeSeconds: step.timeSeconds,
                        stepResultText: step.resultText
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
        .navigationTitle("History Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HistoryDetailView(
            session: PracticeSession(
                topicTitle: "Job Interview Basics",
                questionText: "Introduce yourself in a job interview",
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
