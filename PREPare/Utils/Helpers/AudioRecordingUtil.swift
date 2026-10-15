//
//  AudioRecordingUtil.swift
//  PREPare
//
//  Created by rahdeva on 03/05/26.
//

import AVFoundation
import Observation

/// Runs blocking Core Audio work (session activation, engine start/stop) on one serial
/// background queue, so the main thread never waits on it and calls stay in order.
nonisolated enum AudioWorkQueue {
    private static let queue = DispatchQueue(label: "PREPare.audio-work", qos: .userInitiated)

    static func perform<T>(_ work: @escaping () throws -> T) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            queue.async {
                continuation.resume(with: Result { try work() })
            }
        }
    }

    /// Activates the session for playing back a recording through the speaker.
    static func activatePlayback() async throws {
        try await perform {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .spokenAudio)
            try session.setActive(true)
        }
    }
}

/// UI-facing recorder state. The actual capture runs in `AudioCaptureEngine`.
@Observable
final class AudioRecordingUtil {
    private(set) var isRecording = false
    private(set) var recordingURL: URL?

    var onAudioBuffer: ((AVAudioPCMBuffer) -> Void)?

    @ObservationIgnored private let capture = AudioCaptureEngine()
    @ObservationIgnored private var startTask: Task<Void, Error>?

    func startRecording() async throws {
        guard !isRecording, startTask == nil else { return }

        // A recording that was never saved to history is no longer needed.
        discardUnsavedRecording()

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("m4a")
        capture.onAudioBuffer = onAudioBuffer

        let capture = capture
        let task = Task { try await capture.start(writingTo: url) }
        startTask = task
        defer { startTask = nil }

        try await task.value
        recordingURL = url
        isRecording = true
    }

    /// Stops capturing and finalizes the file. Safe to call while a start is still in progress.
    func stopRecording() async {
        _ = try? await startTask?.value
        guard isRecording else { return }
        isRecording = false
        await capture.stop()
    }

    /// Deletes the last temporary recording if it is still in the temporary directory.
    /// Saved recordings have already been moved to Documents, so this never touches history.
    private func discardUnsavedRecording() {
        guard let url = recordingURL else { return }
        if url.path.hasPrefix(FileManager.default.temporaryDirectory.path) {
            try? FileManager.default.removeItem(at: url)
        }
        recordingURL = nil
    }
}

/// Owns the audio engine and output file. Every method runs on `AudioWorkQueue`, which also
/// serializes access to the mutable state below.
nonisolated final class AudioCaptureEngine: @unchecked Sendable {
    private let engine = AVAudioEngine()
    private var file: AVAudioFile?

    /// Receives every captured buffer on the audio thread (used for speech recognition).
    var onAudioBuffer: ((AVAudioPCMBuffer) -> Void)?

    enum CaptureError: Error {
        case noInputAvailable
    }

    func start(writingTo url: URL) async throws {
        try await AudioWorkQueue.perform { try self.startOnQueue(writingTo: url) }
    }

    func stop() async {
        _ = try? await AudioWorkQueue.perform { self.stopOnQueue() }
    }

    private func startOnQueue(writingTo url: URL) throws {
        let session = AVAudioSession.sharedInstance()
        // `.default` mode keeps iOS voice processing and automatic gain control on, so the
        // recording plays back at a natural speaking level. `.measurement` disables them and
        // produces a very quiet file.
        try session.setCategory(.record, mode: .default, options: .duckOthers)
        try session.setActive(true, options: .notifyOthersOnDeactivation)

        let inputNode = engine.inputNode
        let inputFormat = inputNode.outputFormat(forBus: 0)
        guard inputFormat.sampleRate > 0, inputFormat.channelCount > 0 else {
            throw CaptureError.noInputAvailable
        }

        // Save voice as mono AAC: under 2 MB per minute instead of about 11 MB of raw float PCM.
        // Some inputs deliver several channels (external mics, the Simulator's Mac mic array), which
        // the AAC encoder rejects without a channel layout, so only the first channel is written.
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: inputFormat.sampleRate,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
        ]
        let file = try AVAudioFile(
            forWriting: url,
            settings: settings,
            commonFormat: .pcmFormatFloat32,
            interleaved: false
        )
        self.file = file

        let monoFormat = file.processingFormat
        let onAudioBuffer = onAudioBuffer
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: inputFormat) { buffer, _ in
            do {
                try file.write(from: Self.monoBuffer(from: buffer, format: monoFormat))
            } catch {
                print("Failed to write audio buffer: \(error)")
            }
            onAudioBuffer?(buffer)
        }

        engine.prepare()
        do {
            try engine.start()
        } catch {
            inputNode.removeTap(onBus: 0)
            file.close()
            self.file = nil
            try? FileManager.default.removeItem(at: url)
            throw error
        }
    }

    private func stopOnQueue() {
        engine.stop()
        engine.inputNode.removeTap(onBus: 0)
        // Close explicitly so the AAC file is fully finalized before it is played or moved.
        file?.close()
        file = nil
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }

    /// Returns the buffer itself when it is already mono, otherwise a copy of its first channel.
    private static func monoBuffer(from buffer: AVAudioPCMBuffer, format: AVAudioFormat) -> AVAudioPCMBuffer {
        guard buffer.format.channelCount > 1,
              let source = buffer.floatChannelData,
              let mono = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: buffer.frameLength),
              let destination = mono.floatChannelData
        else { return buffer }

        mono.frameLength = buffer.frameLength
        let stride = buffer.stride
        for frame in 0..<Int(buffer.frameLength) {
            destination[0][frame] = source[0][frame * stride]
        }
        return mono
    }
}
