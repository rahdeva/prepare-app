import SwiftUI

struct DetailPREPStepCard: View {
    let step: PREPStep
    let timeSeconds: Int
    let transcription: String

    private var circleColor: Color {
        switch step {
        case .point: Color.indigo400
        case .reason: Color.green500
        case .example: Color.amber500
        case .restate: Color.purple400
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                Circle()
                    .fill(circleColor)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(step.letter)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(step.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.slate900)

                    Text("Step \(step.number) of \(PREPStep.allCases.count)")
                        .font(.caption)
                        .foregroundStyle(Color.gray500)
                }

                Spacer()

                Text("\(timeSeconds)s")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.slate800)
            }

            Group {
                if transcription.isEmpty {
                    Text("No speech detected")
                } else {
                    Text(transcription)
                }
            }
                .font(.subheadline)
                .foregroundStyle(Color.gray600)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(.white)
        .cornerRadius(16)
        .shadowPrimary()
    }
}

#Preview {
    DetailPREPStepCard(
        step: .point,
        timeSeconds: 30,
        transcription: "My greatest weakness is that I tend to be overly detail-oriented, which sometimes slows me down on tasks."
    )
    .padding(24)
    .background(Color.slate50)
}
