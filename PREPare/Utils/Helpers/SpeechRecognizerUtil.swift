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
    private static let fallbackLocale = Locale(identifier: "en-US")

    @ObservationIgnored private var speechRecognizer: SFSpeechRecognizer?
    @ObservationIgnored private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @ObservationIgnored private var recognitionTask: SFSpeechRecognitionTask?

    private(set) var transcribedText: String = ""
    private(set) var isTranscribing = false
    private(set) var authorizationStatus: SFSpeechRecognizerAuthorizationStatus = .notDetermined

    init(locale: Locale = SpeechRecognizerUtil.fallbackLocale) {
        speechRecognizer = Self.makeRecognizer(for: locale)
    }

    /// Switches the recognition language. Safe to call between sessions; no-op if already set.
    func setLocale(_ locale: Locale) {
        guard speechRecognizer?.locale.identifier != locale.identifier else { return }
        guard !isTranscribing else { return } // Don't swap the recognizer under a running task.
        speechRecognizer = Self.makeRecognizer(for: locale)
    }

    private static func makeRecognizer(for locale: Locale) -> SFSpeechRecognizer? {
        // SFSpeechRecognizer returns nil for unsupported locales; fall back so recording still works.
        SFSpeechRecognizer(locale: locale) ?? SFSpeechRecognizer(locale: fallbackLocale)
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
