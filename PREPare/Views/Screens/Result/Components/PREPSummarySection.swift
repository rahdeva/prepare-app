import SwiftUI

struct PREPStepResult {
    let letter: String
    let title: String
    let stepNumber: Int
    let totalSteps: Int
    let timeSeconds: Int
    let stepResult: String
    let guidelines: [String]
}

struct PREPSummarySection: View {
    let prepStepResults: [PREPStepResult]
    @Binding var expandedSteps: Set<Int>

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PREP Summary")
                .font(.system(size: 20, weight: .bold))
                .padding(.bottom, 4)

            ForEach(Array(prepStepResults.enumerated()), id: \.offset) { index, step in
                PREPStepSummaryCard(
                    letter: step.letter,
                    title: step.title,
                    stepNumber: step.stepNumber,
                    totalSteps: step.totalSteps,
                    timeSeconds: step.timeSeconds,
                    stepResult: step.stepResult,
                    guidelines: step.guidelines,
                    isExpanded: expandedSteps.contains(index),
                    onToggle: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            if expandedSteps.contains(index) {
                                expandedSteps.remove(index)
                            } else {
                                expandedSteps.insert(index)
                            }
                        }
                    }
                )
                .padding(.bottom, 4)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ResultView(path: .constant(NavigationPath()))
    }
}
