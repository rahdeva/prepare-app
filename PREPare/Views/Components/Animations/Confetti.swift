import SwiftUI

struct ConfettiPiece: Identifiable {
    let id = UUID()
    let x: CGFloat
    let color: Color
    let size: CGFloat
    let spinSpeed: Double
    let fallDuration: Double
    let delay: Double
    let shape: ConfettiShape

    enum ConfettiShape: CaseIterable {
        case circle, rectangle, roundedRect
    }
}

struct Confetti: View {
    @State private var animate = false
    @State private var visible = true

    let pieces: [ConfettiPiece] = (0..<50).map { _ in
        ConfettiPiece(
            x: CGFloat.random(in: 0...1),
            color: [
                Color.emerald400, Color.amber400, Color.rose400,
                Color.sky400, Color.violet400, Color.orange400,
                Color.pink400, Color.teal400
            ].randomElement()!,
            size: CGFloat.random(in: 6...12),
            spinSpeed: Double.random(in: 2...4),
            fallDuration: Double.random(in: 2.0...4.0),
            delay: Double.random(in: 0...1.5),
            shape: ConfettiPiece.ConfettiShape.allCases.randomElement()!
        )
    }

    var body: some View {
        GeometryReader { geo in
            if visible {
                ZStack {
                    ForEach(pieces) { piece in
                        ConfettiPieceView(piece: piece, animate: animate)
                            .position(
                                x: piece.x * geo.size.width,
                                y: animate ? geo.size.height + 40 : -40
                            )
                            .animation(
                                .easeIn(duration: piece.fallDuration)
                                .delay(piece.delay),
                                value: animate
                            )
                    }
                }
            }
        }
        .allowsHitTesting(false)
        .onAppear {
            animate = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation(.easeOut(duration: 0.5)) {
                    visible = false
                }
            }
        }
    }
}

struct ConfettiPieceView: View {
    let piece: ConfettiPiece
    let animate: Bool

    @State private var spinning = false

    var body: some View {
        Group {
            switch piece.shape {
            case .circle:
                Circle()
                    .fill(piece.color)
                    .frame(width: piece.size, height: piece.size)
            case .rectangle:
                Rectangle()
                    .fill(piece.color)
                    .frame(width: piece.size, height: piece.size * 0.5)
            case .roundedRect:
                RoundedRectangle(cornerRadius: 2)
                    .fill(piece.color)
                    .frame(width: piece.size * 0.6, height: piece.size * 1.2)
            }
        }
        .rotation3DEffect(
            .degrees(spinning ? 360 : 0),
            axis: (
                x: CGFloat.random(in: 0...1),
                y: CGFloat.random(in: 0...1),
                z: 0
            )
        )
        .animation(
            .linear(duration: piece.spinSpeed)
            .repeatForever(autoreverses: false),
            value: spinning
        )
        .onAppear { spinning = true }
    }
}
