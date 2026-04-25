import SwiftUI

struct PreparationMiddleContent: View {
    let timeRemaining: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(timeRemaining)s")
                .contentTransition(.numericText(value: Double(timeRemaining)))
                .font(.system(size: 80, weight: .bold))
                .foregroundStyle(.white)
            Text("Think about your response")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.8))
        }
    }
}
