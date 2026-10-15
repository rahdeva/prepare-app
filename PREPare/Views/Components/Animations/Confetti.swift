import SwiftUI

struct ConfettiPiece: Identifiable {
    let id = UUID()
    /// Horizontal start position as a fraction of the view width.
    let x: CGFloat
    let color: Color
    let size: CGFloat
    /// Full rotations per second.
    let spinSpeed: Double
    let spinPhase: Double
    let fallDuration: Double
    let delay: Double
    /// Sideways sway amplitude in points and speed in radians per second.
    let swayAmplitude: CGFloat
    let swaySpeed: Double
    let swayPhase: Double
    let shape: ConfettiShape

    enum ConfettiShape: CaseIterable {
        case circle, rectangle, roundedRect
    }

    static let palette: [Color] = [
        .emerald400, .amber400, .rose400, .sky400,
        .violet400, .orange400, .pink400, .teal400
    ]

    static func generate(count: Int) -> [ConfettiPiece] {
        (0..<count).map { _ in
            ConfettiPiece(
                x: CGFloat.random(in: 0...1),
                color: palette.randomElement()!,
                size: CGFloat.random(in: 6...12),
                spinSpeed: Double.random(in: 0.6...1.4),
                spinPhase: Double.random(in: 0...(2 * .pi)),
                fallDuration: Double.random(in: 2.2...4.0),
                delay: Double.random(in: 0...1.5),
                swayAmplitude: CGFloat.random(in: 10...30),
                swaySpeed: Double.random(in: 1.5...3.0),
                swayPhase: Double.random(in: 0...(2 * .pi)),
                shape: ConfettiShape.allCases.randomElement()!
            )
        }
    }

    /// When this piece has fully left the screen.
    var endTime: Double { delay + fallDuration }
}

/// Full-screen confetti rain that plays once when it appears, then removes itself.
///
/// Positions are a pure function of elapsed time, so the effect survives parent re-renders
/// and does not depend on an `onAppear` state change racing the first layout.
struct Confetti: View {
    var count: Int = 60

    @State private var pieces: [ConfettiPiece]
    @State private var startDate = Date()
    @State private var finished = false

    init(count: Int = 60) {
        self.count = count
        _pieces = State(initialValue: ConfettiPiece.generate(count: count))
    }

    private var totalDuration: Double {
        pieces.map(\.endTime).max() ?? 0
    }

    var body: some View {
        ZStack {
            if !finished {
                TimelineView(.animation) { context in
                    let elapsed = context.date.timeIntervalSince(startDate)
                    Canvas(rendersAsynchronously: true) { ctx, size in
                        for piece in pieces {
                            draw(piece, at: elapsed, in: size, context: &ctx)
                        }
                    }
                }
                .transition(.opacity)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
        .task {
            startDate = Date()
            try? await Task.sleep(for: .seconds(totalDuration))
            withAnimation(.easeOut(duration: 0.3)) { finished = true }
        }
    }

    private func draw(_ piece: ConfettiPiece, at elapsed: Double, in size: CGSize, context ctx: inout GraphicsContext) {
        let t = elapsed - piece.delay
        guard t >= 0 else { return }
        let progress = t / piece.fallDuration
        guard progress <= 1 else { return }

        // Ease-in so pieces start slow and pick up speed like they're falling.
        let eased = progress * progress
        let travel = size.height + piece.size * 4
        let y = -piece.size * 2 + eased * travel
        let sway = sin(t * piece.swaySpeed + piece.swayPhase) * piece.swayAmplitude
        let x = piece.x * size.width + sway

        // Flip around a horizontal axis by squashing the height with a cosine, plus a slow in-plane spin.
        let flip = cos(t * piece.spinSpeed * 2 * .pi + piece.spinPhase)
        let spin = Angle.radians(t * piece.spinSpeed * .pi + piece.spinPhase)

        // Fade out over the last 15% of the fall.
        let opacity = progress > 0.85 ? (1 - progress) / 0.15 : 1

        var layer = ctx
        layer.opacity = opacity
        layer.translateBy(x: x, y: y)
        layer.rotate(by: spin)
        layer.scaleBy(x: 1, y: max(abs(flip), 0.15))

        let rect: CGRect
        let path: Path
        switch piece.shape {
            case .circle:
                rect = CGRect(x: -piece.size / 2, y: -piece.size / 2, width: piece.size, height: piece.size)
                path = Path(ellipseIn: rect)
            case .rectangle:
                rect = CGRect(x: -piece.size / 2, y: -piece.size / 4, width: piece.size, height: piece.size * 0.5)
                path = Path(rect)
            case .roundedRect:
                rect = CGRect(x: -piece.size * 0.3, y: -piece.size * 0.6, width: piece.size * 0.6, height: piece.size * 1.2)
                path = Path(roundedRect: rect, cornerRadius: 2)
        }
        layer.fill(path, with: .color(piece.color))
    }
}

#Preview {
    ZStack {
        Color.slate50.ignoresSafeArea()
        Text("Great Job!")
            .font(.largeTitle.bold())
    }
    .overlay(Confetti())
}
