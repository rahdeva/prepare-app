# PREPare

PREPare is an iPhone and iPad app for practicing spontaneous speaking with the **PREP** framework. You answer a question out loud within a time limit. The app records and transcribes your answer, and you rate yourself afterwards.

Available in English and Bahasa Indonesia.

## The PREP framework

1. **Point**: state your main opinion.
2. **Reason**: explain why.
3. **Example**: give a concrete example.
4. **Point (Restate)**: repeat your main opinion as a closing.

## Features

- **Question bank**: 10 topics in 3 categories (Career, Personal Growth, Education), with 10 questions each.
- **Timed practice**: preparation time from 0 s to 2 min (it can be skipped), and a target speaking time from 1 to 20 min.
- **Guided steps**: speak one PREP step at a time. The timer turns red past the target.
- **Recording and playback**: the whole answer is saved as mono AAC and can be scrubbed during playback.
- **Transcription**: speech to text for each step, in the in-app language (en-US or id-ID).
- **Self-evaluation**: a 1–5 star rating and notes, which can be edited later in History.
- **History**: every session, with time per step, transcripts, the recording, and the evaluation.
- **Streak and activity**: the day streak on Home, plus a calendar heatmap with total sessions, current streak, and best streak.
- **Daily reminder**: a local notification at a time you choose (19:00 by default).
- **In-app language switch**: English and Bahasa Indonesia, independent of the system language.

## Requirements

| | |
|---|---|
| iOS / iPadOS | 18.0 or later |
| Xcode | 26 or later |
| Version | 2.0.0 (build 3) |
| Bundle ID | `com.adeventures.PREPare` |

Permissions: Microphone and Speech Recognition (needed to practice), and Notifications (only when daily reminders are turned on).

## Tech stack

Native Swift and SwiftUI, MVVM, with no third-party dependencies.

| Area | Technology |
|---|---|
| UI and navigation | SwiftUI, `NavigationStack` with `AppRoute` |
| State | Observation (`@Observable`): `GeneralViewModel`, `PracticeViewModel`, `HistoryViewModel` |
| Persistence | SwiftData (`PracticeSession`), plus UserDefaults through `LocalStorageUtil` |
| Recording | AVFoundation (`AVAudioEngine`, `AVAudioFile`), off the main thread |
| Transcription | Speech (`SFSpeechRecognizer`) |
| Reminders | UserNotifications (`NotificationService`) |
| Localization | String Catalog (`Localizable.xcstrings`) |

## Project structure

```
PREPare/
├── App.swift              App entry: model container and view models
├── Models/                PracticeSession, Topic/Question, PREPStep
├── ViewModels/            General, Practice, History
├── Views/
│   ├── Screens/           One folder per screen (Home, Practice, Result, History, ...)
│   ├── Components/        Shared buttons, cards, animations
│   └── Navigation/        AppRoute and router
├── Services/              NotificationService
├── Utils/                 Recording, speech, storage, stats, UI-testing helpers
├── Data/Local/            Topics, questions, languages
└── Theme/                 Colors, fonts, spacing, icons
PREPareTests/              Unit tests (Swift Testing)
PREPareUITests/            End-to-end UI tests (XCUITest)
```

## Brand colors

| Name | Hex |
|---|---|
| Primary (`primaryColor`) | `#213C51` |
| Secondary (`secondaryColor`) | `#6594B1` |
| Primary gradient | `#213C51` → `#6594B1`, from top leading to bottom trailing |

## Getting started

1. Open `PREPare.xcodeproj` in Xcode.
2. Select the `PREPare` scheme and an iPhone simulator or device.
3. Press ⌘R.

## Testing

Run all tests with ⌘U in Xcode, or from the command line:

```sh
xcodebuild test \
  -project PREPare.xcodeproj \
  -scheme PREPare \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
```

- **Unit tests** (`PREPareTests`) cover streak math, History persistence and recording files, settings, the practice flow, topic data, and Indonesian translations.
- **UI tests** (`PREPareUITests`) run the real app end to end: onboarding, a full recorded practice, rating and notes, History editing, keeping a session when the app is closed on Result, streak and activity, deleting history, language switching, and reminders. They take about 6–7 minutes.

UI tests launch the app with `-UITesting`, which uses a separate store and UserDefaults suite, so real data is never touched. These launch options only work in Debug builds. The simulator must allow microphone access for PREPare, or the practice tests stop at the "Permissions Required" alert.

## Privacy

All data stays on the device. There is no server, account, or analytics, and outgoing network connections are disabled for the target. Sessions are stored in SwiftData and recordings as `.m4a` files in the app's Documents folder. **Settings → Delete All History** removes both. Apple's speech recognition may process audio on Apple's servers, depending on the device and language.
