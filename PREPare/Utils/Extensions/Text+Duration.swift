//
//  Text+Duration.swift
//  PREPare
//

import SwiftUI

extension Text {
    /// Short duration label such as "30s", "2m" or "1m 30s", localized through Localizable.xcstrings.
    init(duration seconds: Int) {
        let minutes = seconds / 60
        let remainder = seconds % 60
        if minutes == 0 {
            self.init("\(remainder)s", comment: "Duration in seconds only.")
        } else if remainder == 0 {
            self.init("\(minutes)m", comment: "Duration in whole minutes.")
        } else {
            self.init("\(minutes)m \(remainder)s", comment: "Duration in minutes and seconds.")
        }
    }

    /// Clock style label such as "2:05". Digits and colon are not localized.
    init(clock seconds: Int) {
        self.init(verbatim: String(format: "%d:%02d", seconds / 60, seconds % 60))
    }
}
