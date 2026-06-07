//
//  SpeechRecognizerUtil.swift
//  PREPare
//
//  Created by rahdeva on 03/05/26.
//

import Speech
import Observation

@Observable
final class SpeechRecognizerUtil {
    private let speechRecognizer: SFSpeechRecognizer?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?

    private(set) var transcribedText: String = ""
    private(set) var isTranscribing = false
    private(set) var authorizationStatus: SFSpeechRecognizerAuthorizationStatus = .notDetermined

    init(locale: Locale = Locale(identifier: "en-US")) {
        speechRecognizer = SFSpeechRecognizer(locale: locale)
    }

    func requestAuthorization() async -> Bool {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { [weak self] status in
                self?.authorizationStatus = status
                continuation.resume(returning: status == .authorized)
            }
        }
    }

    func startTranscribing() {
        recognitionTask?.cancel()
        recognitionTask = nil

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest else { return }
        recognitionRequest.shouldReportPartialResults = true

        transcribedText = ""
        isTranscribing = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let self else { return }
            if let result {
                self.transcribedText = result.bestTranscription.formattedString
            }
            if error != nil || (result?.isFinal ?? false) {
                self.isTranscribing = false
            }
        }
    }

    func appendBuffer(_ buffer: AVAudioPCMBuffer) {
        recognitionRequest?.append(buffer)
    }

    @discardableResult
    func stopTranscribing() -> String {
        let finalText = transcribedText
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        recognitionRequest = nil
        recognitionTask = nil
        isTranscribing = false
        return finalText
    }
}
