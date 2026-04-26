import SwiftUI

struct DetailPREPStepCard: View {
    let letter: String
    let title: String
    let stepNumber: Int
    let totalSteps: Int
    let timeSeconds: Int
    let stepResultText: String

    private var circleColor: Color {
        switch stepNumber {
        case 1: return Color.indigo400
        case 2: return Color.green500
        case 3: return Color.amber500
        case 4: return Color.purple400
        default: return Color.gray400
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                Circle()
                    .fill(circleColor)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(letter)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.slate900)

                    Text("Step \(stepNumber) of \(totalSteps)")
                        .font(.caption)
                        .foregroundStyle(Color.gray500)
                }

                Spacer()

                Text("\(timeSeconds)s")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.slate800)
            }

            Text(stepResultText)
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
        letter: "P",
        title: "Point",
        stepNumber: 1,
        totalSteps: 4,
        timeSeconds: 30,
        stepResultText: "My greatest weakness is that I tend to be overly detail-oriented, which sometimes slows me down on tasks."
    )
    .padding(24)
    .background(Color.slate50)
}
