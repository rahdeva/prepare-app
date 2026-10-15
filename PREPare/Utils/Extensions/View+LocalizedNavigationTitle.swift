//
//  View+LocalizedNavigationTitle.swift
//  PREPare
//

import SwiftUI

extension View {
    /// Navigation title that follows the in-app language.
    ///
    /// `.navigationTitle(LocalizedStringKey)` is handed to UIKit's navigation bar, which does not
    /// re-resolve the same key when `\.locale` changes. Resolving it here produces a new string
    /// whenever the language changes, so the bar updates immediately.
    func localizedNavigationTitle(_ key: String.LocalizationValue) -> some View {
        modifier(LocalizedNavigationTitle(key: key))
    }
}

private struct LocalizedNavigationTitle: ViewModifier {
    @Environment(\.locale) private var locale
    let key: String.LocalizationValue

    func body(content: Content) -> some View {
        content.navigationTitle(String(localized: LocalizedStringResource(key, locale: locale)))
    }
}
