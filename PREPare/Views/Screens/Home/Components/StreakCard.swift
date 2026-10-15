import SwiftUI

struct StreakCard: View {
    let streak: Int
    let hasPracticedToday: Bool

    private enum StreakState {
        case none      // no active streak
        case atRisk    // streak alive, but today's practice not done yet
        case done      // practiced today
    }

    private var state: StreakState {
        if hasPracticedToday { .done } else if streak > 0 { .atRisk } else { .none }
    }

    private var statusText: LocalizedStringKey {
        switch state {
        case .done: "Practiced today. Keep it up!"
        case .atRisk: "Practice today to keep your streak going"
        case .none: "Practice today to start a new streak"
        }
    }

    private var gradient: LinearGradient {
        switch state {
        case .done: .orangeGradient
        case .atRisk: .amberGradient
        case .none: .grayGradient
        }
    }

    var body: some View {
        ZStack{
            CircleOrnament()
            
            HStack{
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .bottom, spacing: 8){
                        Text(streak, format: .number)
                            .font(.system(size: 60))
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .contentTransition(.numericText())

                        Text("day streak")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .offset(y: -12)
                    }

                    Text(statusText)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                icon
                    .frame(width: 100, height: 100)
            }
            .padding(24)
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(gradient)
        )
        .padding(.horizontal, 24)
        .cornerRadius(24)
        .shadowPrimary()
        .accessibilityElement(children: .combine)
        .animation(.default, value: state)
    }

    @ViewBuilder
    private var icon: some View {
        switch state {
        case .done:
            ZStack(alignment: .topTrailing) {
                Image(systemName: "flame.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundStyle(Color(UIColor(hex: "#FFCF3E")))

                Image(systemName: "sparkles")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color(UIColor(hex: "#FFCF3E")))
                    .offset(x: 15, y: -15)
            }

        case .atRisk:
            ZStack(alignment: .topTrailing) {
                glassCircle(systemName: "clock")

                // Red dot flags that today's practice is still pending.
                Circle()
                    .fill(Color(UIColor(hex: "#ED6C4E")))
                    .frame(width: 20, height: 20)
                    .overlay(Circle().stroke(.white.opacity(0.6), lineWidth: 1.5))
                    .offset(x: 2, y: -2)
            }

        case .none:
            glassCircle(systemName: "sparkle")
        }
    }

    /// Translucent circle with a white symbol, matching the inactive and at-risk states of the design.
    private func glassCircle(systemName: String) -> some View {
        ZStack {
            Circle()
                .fill(.white.opacity(0.22))
                .overlay(Circle().stroke(.white.opacity(0.35), lineWidth: 1))

            Image(systemName: systemName)
                .font(.system(size: 40, weight: .regular))
                .foregroundStyle(.white)
        }
        .frame(width: 88, height: 88)
    }
}

#Preview {
    VStack(spacing: 20) {
        StreakCard(streak: 0, hasPracticedToday: false)
        StreakCard(streak: 5, hasPracticedToday: false)
        StreakCard(streak: 6, hasPracticedToday: true)
    }
}
