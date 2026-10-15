import SwiftUI
import AVFoundation

struct RecordingResultCard: View {
    let totalDurationSeconds: Int
    let recordingURL: URL?

    @State private var isPlaying = false
    @State private var isScrubbing = false
    @State private var audioPlayer: AVAudioPlayer?
    /// 0...1, drives both the bar and the knob. Updated by the timer while playing and by the drag while scrubbing.
    @State private var playbackProgress: Double = 0
    @State private var currentTimeSeconds: Double = 0
    @State private var progressTimer: Timer?

    private var hasRecording: Bool { recordingURL != nil }

    /// Prefer the real file duration once the player is loaded; fall back to the recorded session time.
    private var durationSeconds: Double {
        if let duration = audioPlayer?.duration, duration > 0 { return duration }
        return Double(totalDurationSeconds)
    }

    // MARK: - Playback

    private func togglePlayback() {
        if isPlaying {
            pausePlayback()
            return
        }
        Task {
            guard let player = await loadPlayerIfNeeded() else { return }
            if playbackProgress >= 1 { seek(toProgress: 0) }
            // Honor a position the user scrubbed to before pressing play.
            player.currentTime = playbackProgress * player.duration
            player.play()
            isPlaying = true
            startProgressTimer()
        }
    }

    private func pausePlayback() {
        audioPlayer?.pause()
        progressTimer?.invalidate()
        isPlaying = false
    }

    private func loadPlayerIfNeeded() async -> AVAudioPlayer? {
        if let audioPlayer { return audioPlayer }
        guard let url = recordingURL else { return nil }
        do {
            // Session activation can block, so it runs off the main thread.
            try await AudioWorkQueue.activatePlayback()
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            audioPlayer = player
            return player
        } catch {
            print("Playback error: \(error)")
            return nil
        }
    }

    private func startProgressTimer() {
        progressTimer?.invalidate()
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            guard let player = audioPlayer else { return }
            // The drag owns the position while the user is scrubbing.
            guard !isScrubbing else { return }
            if player.isPlaying {
                currentTimeSeconds = player.currentTime
                playbackProgress = player.currentTime / max(player.duration, 1)
            } else {
                progressTimer?.invalidate()
                isPlaying = false
                if player.currentTime >= player.duration - 0.1 {
                    seek(toProgress: 0)
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
        isScrubbing = false
        playbackProgress = 0
        currentTimeSeconds = 0
    }

    // MARK: - Scrubbing

    private func seek(toProgress progress: Double) {
        let clamped = min(max(progress, 0), 1)
        playbackProgress = clamped
        currentTimeSeconds = clamped * durationSeconds
        if let player = audioPlayer {
            player.currentTime = clamped * player.duration
        }
    }

    private func scrubGesture(width: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                isScrubbing = true
                seek(toProgress: value.location.x / max(width, 1))
            }
            .onEnded { value in
                seek(toProgress: value.location.x / max(width, 1))
                isScrubbing = false
                // Loading here means the displayed time matches the real file and play starts instantly.
                if audioPlayer == nil {
                    Task {
                        guard let player = await loadPlayerIfNeeded() else { return }
                        player.currentTime = playbackProgress * player.duration
                        currentTimeSeconds = player.currentTime
                    }
                }
            }
    }

    // MARK: - View

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
                .disabled(!hasRecording)

                VStack(spacing: 6) {
                    HStack {
                        Text(clock: Int(currentTimeSeconds))
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.8))

                        Spacer()

                        Text(clock: Int(durationSeconds.rounded()))
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.8))
                    }

                    progressSlider
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.opacity(0.15))
            )

            Group {
                if hasRecording {
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

    private let knobSize: CGFloat = 14
    private let sliderHitHeight: CGFloat = 24

    private var progressSlider: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let fillWidth = width * playbackProgress

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(.white.opacity(0.3))
                    .frame(height: 4)

                RoundedRectangle(cornerRadius: 2)
                    .fill(.white)
                    .frame(width: fillWidth, height: 4)

                Circle()
                    .fill(.white)
                    .frame(width: knobSize, height: knobSize)
                    .scaleEffect(isScrubbing ? 1.3 : 1)
                    .shadow(color: .black.opacity(0.2), radius: 2, y: 1)
                    .offset(x: fillWidth - knobSize / 2)
            }
            .frame(height: sliderHitHeight)
            // A taller, rectangular hit area makes the thin bar easy to grab.
            .contentShape(Rectangle())
            // High priority so a touch on the bar scrubs instead of scrolling the parent ScrollView.
            .highPriorityGesture(scrubGesture(width: width))
            .animation(.easeOut(duration: 0.15), value: isScrubbing)
        }
        .frame(height: sliderHitHeight)
        .padding(.horizontal, knobSize / 2)
        .disabled(!hasRecording)
        .accessibilityElement()
        .accessibilityLabel(Text("Playback position"))
        .accessibilityValue(Text(clock: Int(currentTimeSeconds)))
        .accessibilityAdjustableAction { direction in
            let step = 5 / max(durationSeconds, 1)
            switch direction {
                case .increment: seek(toProgress: playbackProgress + step)
                case .decrement: seek(toProgress: playbackProgress - step)
                @unknown default: break
            }
        }
    }
}

#Preview {
    RecordingResultCard(totalDurationSeconds: 150, recordingURL: nil)
        .padding(24)
        .background(Color.slate50)
}
