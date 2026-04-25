import SwiftUI

struct PreparationBottomContent: View {
    let prepSeconds: Int
    let progress: CGFloat
    let onSkip: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 10) {
                Image(systemName: "clock").foregroundStyle(.white.opacity(0.8))
                VStack(alignment: .leading, spacing: 2) {
                    Text("Preparation Time")
                        .font(.subheadline).fontWeight(.semibold).foregroundStyle(.white)
                    Text("\(prepSeconds)s to organize your thoughts")
                        .font(.caption).foregroundStyle(.white.opacity(0.7))
                }
                Spacer()
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .stroke(.white, lineWidth: 0.8)
            )
            .padding(.horizontal, 24)
            .shadowPrimary()
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4).fill(.white.opacity(0.2)).frame(height: 4)
                    RoundedRectangle(cornerRadius: 4).fill(.white)
                        .frame(width: geo.size.width * progress, height: 4)
                        .animation(.linear(duration: 1), value: progress)
                }
            }
            .frame(height: 4)
            .padding(.horizontal, 24)
            .shadowPrimary()
            
            PrimaryButton(title: "Skip Preparation", action: onSkip)
        }
    }
}

#Preview {
    NavigationStack {
        PracticeView(path: .constant(NavigationPath()))
    }
}
