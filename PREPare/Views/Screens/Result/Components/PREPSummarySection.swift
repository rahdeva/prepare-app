import SwiftUI

struct PREPStepResult: Identifiable {
    let step: PREPStep
    let timeSeconds: Int
    let transcription: String

    var id: PREPStep.ID { step.id }
}

struct PREPSummarySection: View {
    let prepStepResults: [PREPStepResult]
    @Binding var expandedSteps: Set<Int>

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("PREP Summary")
                .font(.system(size: 20, weight: .bold))
                .padding(.bottom, 4)

            ForEach(prepStepResults) { result in
                let index = result.id
                PREPStepSummaryCard(
                    step: result.step,
                    timeSeconds: result.timeSeconds,
                    transcription: result.transcription,
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
