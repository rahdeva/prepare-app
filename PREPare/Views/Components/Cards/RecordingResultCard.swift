import SwiftUI
import AVFoundation

struct RecordingResultCard: View {
    let totalDurationSeconds: Int
    let recordingURL: URL?

    @State private var isPlaying = false
    @State private var audioPlayer: AVAudioPlayer?
    @State private var playbackProgress: Double = 0
    @State private var progressTimer: Timer?

    private var currentTimeSeconds: Int {
        Int(audioPlayer?.currentTime ?? 0)
    }

    private func togglePlayback() {
        if isPlaying {
            audioPlayer?.pause()
            progressTimer?.invalidate()
            isPlaying = false
        } else if let player = audioPlayer {
            if player.currentTime >= player.duration {
                player.currentTime = 0
                playbackProgress = 0
            }
            player.play()
            startProgressTimer()
            isPlaying = true
        } else {
            startPlayback()
        }
    }

    private func startPlayback() {
        guard let url = recordingURL else { return }
        Task {
            do {
                // Session activation can block, so it runs off the main thread.
                try await AudioWorkQueue.activatePlayback()
                let player = try AVAudioPlayer(contentsOf: url)
                audioPlayer = player
                player.play()
                isPlaying = true
                startProgressTimer()
            } catch {
                print("Playback error: \(error)")
            }
        }
    }

    private func startProgressTimer() {
        progressTimer?.invalidate()
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            guard let player = audioPlayer else { return }
            if player.isPlaying {
                playbackProgress = player.currentTime / max(player.duration, 1)
            } else {
                progressTimer?.invalidate()
                isPlaying = false
                if player.currentTime >= player.duration - 0.1 {
                    playbackProgress = 0
                    player.currentTime = 0
                }
            }
        }
    }

    private func stopPlayback() {
        audioPlayer?.stop()
        audioPlayer = nil
        progressTimer?.invalidate()
        progressTimer = nil
        isPlaying = false
        playbackProgress = 0
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
                    togglePlayback()
                } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.body)
                        .foregroundStyle(Color.primaryColor)
                        .frame(width: 40, height: 40)
                        .background(Circle().fill(.white))
                }

                VStack(spacing: 6) {
                    HStack {
                        Text(clock: currentTimeSeconds)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.8))

                        Spacer()

                        Text(clock: totalDurationSeconds)
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
                                .frame(width: geo.size.width * playbackProgress, height: 4)
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

            Group {
                if recordingURL != nil {
                    Text("Listen to your practice session")
                } else {
                    Text("No recording available")
                }
            }
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
        .onDisappear { stopPlayback() }
    }
}

#Preview {
    RecordingResultCard(totalDurationSeconds: 150, recordingURL: nil)
        .padding(24)
        .background(Color.slate50)
}
