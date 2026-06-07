//
//  AudioRecordingUtil.swift
//  PREPare
//
//  Created by rahdeva on 03/05/26.
//

import AVFoundation
import Observation

@Observable
final class AudioRecordingUtil {
    private let audioEngine = AVAudioEngine()
    private var audioFile: AVAudioFile?

    private(set) var isRecording = false
    private(set) var recordingURL: URL?

    var onAudioBuffer: ((AVAudioPCMBuffer) -> Void)?

    func configureAudioSession() throws {
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(.record, mode: .measurement, options: .duckOthers)
        try session.setActive(true, options: .notifyOthersOnDeactivation)
    }

    func startRecording() throws {
        guard !isRecording else { return }

        try configureAudioSession()

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("caf")

        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)

        audioFile = try AVAudioFile(forWriting: url, settings: format.settings)
        recordingURL = url

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            try? self?.audioFile?.write(from: buffer)
            self?.onAudioBuffer?(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()
        isRecording = true
    }

    func stopRecording() {
        guard isRecording else { return }
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        audioFile = nil
        isRecording = false
    }

    func deactivateAudioSession() {
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
}
