import SwiftUI

struct PreparationBottomContent: View {
    let onSkip: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 10) {
                    Image(systemName: "waveform.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.white.opacity(0.8))

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Recording Tips")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                        Text("Speak clearly and keep your phone close for the best recording quality")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                }

                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                        Text("Speak at a normal volume")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                        Text("Hold phone 6-8 inches away")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .stroke(.white, lineWidth: 0.8)
            )
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
