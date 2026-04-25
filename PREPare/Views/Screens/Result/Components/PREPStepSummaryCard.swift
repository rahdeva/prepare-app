import SwiftUI

struct PREPStepSummaryCard: View {
    let letter: String
    let title: String
    let stepNumber: Int
    let totalSteps: Int
    let timeSeconds: Int
    let stepResult: String
    let guidelines: [String]
    let isExpanded: Bool
    let onToggle: () -> Void

    var body: some View {
        VStack(spacing: 0){
            VStack(alignment: .leading, spacing: 12){
                HStack(alignment: .top) {
                    Text(letter)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(width: 36, height: 36)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient.primaryGradient)
                        )

                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.semibold)

                        Text("Step \(stepNumber) of \(totalSteps)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Text("\(timeSeconds)s")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.primaryColor)
                }


                Text(stepResult)
                    .font(.subheadline)
                    .foregroundStyle(Color.gray900)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background(Color.gray100)
                    .cornerRadius(12)

                Divider()

                Button(action: onToggle) {
                    HStack(spacing: 8) {
                        Image(systemName: "lightbulb.max.fill")
                            .font(.caption)
                            .foregroundStyle(Color.yellow500)

                        Text("What should be in this step?")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray700)

                        Spacer()

                        Image(systemName: isExpanded ? "chevron.up" :  "chevron.down")
                            .font(.caption)
                            .foregroundStyle(Color.gray700)
                    }
                }
                .buttonStyle(.plain)
                .padding(12)
                .background(Color.gray100)
                .cornerRadius(12)
            }
            .padding(16)

            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(guidelines, id: \.self) { guideline in
                        HStack(alignment: .center, spacing: 8) {
                            Circle()
                                .fill(Color.gray500)
                                .frame(width: 6, height: 6)

                            Text(guideline)
                                .font(.subheadline)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(Color.secondaryColor.opacity(0.1))
            }
        }
        .background(.white)
        .cornerRadius(16)
        .shadowPrimary()
    }
}

#Preview {
    NavigationStack {
        ResultView(path: .constant(NavigationPath()))
    }
}
