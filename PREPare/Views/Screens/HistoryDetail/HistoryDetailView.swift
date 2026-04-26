import SwiftUI

struct HistoryDetailView: View {
    private let prepSteps: [(letter: String, title: String, stepNumber: Int, timeSeconds: Int, resultText: String)] = [
        ("P", "Point", 1, 30, "My greatest weakness is that I tend to be overly detail-oriented, which sometimes slows me down on tasks."),
        ("R", "Reason", 2, 30, "This matters because in fast-paced environments, spending too much time perfecting small details can delay overall project delivery."),
        ("E", "Example", 3, 30, "For instance, in my previous role I spent an extra two days refining a report layout that was already approved, which pushed back the submission deadline."),
        ("P", "Point (restate)", 4, 30, "So while being detail-oriented is a strength, I've been actively working on setting time limits to balance quality with efficiency."),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                DetailTopicCard(
                    topicName: "Job Interview Basics",
                    question: "Introduce yourself in a job interview",
                    date: "Wednesday, April 15, 2026"
                )

                DetailTimeCard(
                    totalTimeSeconds: 120,
                    targetTimeSeconds: 150
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

                DetailRatingCard(rating: 4)
                    .padding(.top, 4)

                DetailNotesCard(notes: "Good flow, need to work on examples")
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
        HistoryDetailView()
    }
}
