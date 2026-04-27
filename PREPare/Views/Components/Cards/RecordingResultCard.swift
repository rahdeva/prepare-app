import SwiftUI

struct RecordingResultCard: View {
    let totalDurationSeconds: Int

    @State private var isPlaying = false

    private var formattedDuration: String {
        let minutes = totalDurationSeconds / 60
        let seconds = totalDurationSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "speaker.wave.2.fill")
                    .font(.subheadline)
                    .foregroundStyle(.white)

                Text("Your Recording")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }

            HStack(spacing: 12) {
                Button {
                    isPlaying.toggle()
                } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.body)
                        .foregroundStyle(Color.primaryColor)
                        .frame(width: 40, height: 40)
                        .background(Circle().fill(.white))
                }

                VStack(spacing: 6) {
                    HStack {
                        Text("0s")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.8))

                        Spacer()

                        Text(formattedDuration)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.8))
                    }

                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(.white.opacity(0.3))
                                .frame(height: 4)

                            RoundedRectangle(cornerRadius: 2)
                                .fill(.white)
                                .frame(width: 0, height: 4)
                        }
                    }
                    .frame(height: 4)
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.opacity(0.15))
            )

            Text("Listen to your practice session")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient.primaryGradient)
        )
        .shadowPrimary()
    }
}

#Preview {
    RecordingResultCard(totalDurationSeconds: 150)
        .padding(24)
        .background(Color.slate50)
}
