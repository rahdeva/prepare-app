import SwiftUI

struct RecordingIndicatorCard: View {
    @State private var isAnimating = false

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.successColor)
                        .frame(width: 10, height: 10)
                        .opacity(isAnimating ? 1 : 0.4)
                        .animation(
                            .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                            value: isAnimating
                        )

                    Text("Recording")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }

                Text("Speak clearly and confidently")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.leading, 18)
            }

            Spacer()

            AudioWaveformView()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .stroke(.white, lineWidth: 0.8)
        )
        .padding(.horizontal, 24)
        .shadowPrimary()
        .onAppear { isAnimating = true }
    }
}

struct AudioWaveformView: View {
    let barCount = 5
    @State private var animating = false

    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<barCount, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(.white.opacity(0.8))
                    .frame(width: 4, height: animating ? barHeight(for: index) : 8)
                    .animation(
                        .easeInOut(duration: duration(for: index))
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.1),
                        value: animating
                    )
            }
        }
        .onAppear { animating = true }
    }

    private func barHeight(for index: Int) -> CGFloat {
        switch index {
        case 0: return 16
        case 1: return 24
        case 2: return 32
        case 3: return 20
        case 4: return 28
        default: return 16
        }
    }

    private func duration(for index: Int) -> Double {
        switch index {
        case 0: return 0.5
        case 1: return 0.4
        case 2: return 0.6
        case 3: return 0.45
        case 4: return 0.55
        default: return 0.5
        }
    }
}

#Preview {
    ZStack {
        LinearGradient.primaryGradient.ignoresSafeArea()
        RecordingIndicatorCard()
    }
}
