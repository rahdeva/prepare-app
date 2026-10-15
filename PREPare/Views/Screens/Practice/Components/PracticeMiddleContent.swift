import SwiftUI

struct PracticeMiddleContent: View {
    let currentPREPIndex: Int

    private var steps: [PREPStep] { PREPStep.allCases }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                ForEach(steps) { step in
                    let index = step.rawValue
                    VStack(spacing: 4) {
                        Rectangle()
                            .fill(
                                index == currentPREPIndex
                                    ? Color.white
                                    : index < currentPREPIndex
                                        ? Color.successColor
                                        : Color.white.opacity(0.3)
                            )
                            .frame(height: 8)
                            .cornerRadius(16)
                            .padding(.bottom, 4)
                        
                        Text(step.letter)
                            .font(.callout)
                            .fontWeight(index == currentPREPIndex ? .bold : .regular)
                            .foregroundStyle(index <= currentPREPIndex ? .white : .white.opacity(0.5))
                    }
                    if index < steps.count - 1 { Spacer() }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Text(steps[currentPREPIndex].practiceLabel)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 20)
            
            Spacer()
        }
    }
}

#Preview {
    NavigationStack {
        PracticeView(path: .constant(NavigationPath()))
    }
}
