import SwiftUI

struct ResultView: View {
    @Binding var path: NavigationPath

    let totalTimeSeconds: Int = 150
    let targetTimeSeconds: Int = 120

    @State private var rating: Int = 0
    @State private var notes: String = ""
    @State private var expandedSteps: Set<Int> = []

    let prepStepResults: [PREPStepResult] = [
        PREPStepResult(
            letter: "P", title: "Point", stepNumber: 1, totalSteps: 4, timeSeconds: 30,
            stepResult: "My greatest weakness is that I tend to be overly detail-oriented, which sometimes slows me down on tasks.",
            guidelines: [
                "Clear and concise main statement",
                "Easy to understand and remember",
                "Directly answers the question or topic",
                "Sets the direction for your entire response"
            ]
        ),
        PREPStepResult(
            letter: "R", title: "Reason", stepNumber: 2, totalSteps: 4, timeSeconds: 45,
            stepResult: "This matters because in fast-paced environments, spending too much time perfecting small details can delay overall project delivery.",
            guidelines: [
                "Explains the \"why\" behind your point",
                "Provides logical justification",
                "Connects to broader context or impact",
                "Makes your argument more convincing"
            ]
        ),
        PREPStepResult(
            letter: "E", title: "Example", stepNumber: 3, totalSteps: 4, timeSeconds: 52,
            stepResult: "For instance, in my previous role I spent an extra two days refining a report layout that was already approved, which pushed back the submission deadline.",
            guidelines: [
                "Specific, concrete illustration",
                "Real-world scenario or case study",
                "Makes your point relatable and memorable",
                "Provides evidence to support your claim"
            ]
        ),
        PREPStepResult(
            letter: "P", title: "Point (Restate)", stepNumber: 4, totalSteps: 4, timeSeconds: 23,
            stepResult: "So while being detail-oriented is a strength, I've been actively working on setting time limits to balance quality with efficiency.",
            guidelines: [
                "Reinforces your main message",
                "Provides a strong conclusion",
                "May be slightly rephrased for impact",
                "Leaves a lasting impression on your audience"
            ]
        )
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 24) {
                    ResultHeader()

                    TimeSummaryCard(
                        totalTimeSeconds: totalTimeSeconds,
                        targetTimeSeconds: targetTimeSeconds
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
                
                ResultBottomButtons(path: $path)
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
    }
}
