import SwiftUI

struct PracticeMiddleContent: View {
    let prepSteps: [String]
    let prepStepNames: [String]
    let currentPREPIndex: Int
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                ForEach(Array(prepSteps.enumerated()), id: \.offset) { index, letter in
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
                        
                        Text(letter)
                            .font(.callout)
                            .fontWeight(index == currentPREPIndex ? .bold : .regular)
                            .foregroundStyle(index <= currentPREPIndex ? .white : .white.opacity(0.5))
                    }
                    if index < prepSteps.count - 1 { Spacer() }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            Text(prepStepNames[currentPREPIndex])
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.white.opacity(0.2))
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
