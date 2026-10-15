//
//  View+LightStatusBar.swift
//  PREPare
//

import SwiftUI

/// Set to `true` by screens that sit on a dark (blue) full-screen background.
struct LightStatusBarPreferenceKey: PreferenceKey {
    static let defaultValue = false

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = value || nextValue()
    }
}

extension View {
    /// Requests white status bar text while this screen is visible.
    /// The app root reads the request in `appColorScheme()`.
    func lightStatusBar() -> some View {
        modifier(LightStatusBarModifier())
    }

    /// Applied once at the app root. The status bar follows the window's color scheme, so the
    /// window switches to dark only while a screen requests a light status bar. All content keeps
    /// rendering in light mode, so materials and system colors never change.
    func appColorScheme() -> some View {
        modifier(AppColorSchemeModifier())
    }
}

/// Screens pushed underneath another screen stay in the navigation hierarchy, so the request is
/// tied to visibility. Otherwise a light screen pushed on top would inherit the white status bar.
private struct LightStatusBarModifier: ViewModifier {
    @State private var isVisible = false

    func body(content: Content) -> some View {
        content
            .toolbarColorScheme(.dark, for: .navigationBar)
            .preference(key: LightStatusBarPreferenceKey.self, value: isVisible)
            .onAppear { isVisible = true }
            .onDisappear { isVisible = false }
    }
}

private struct AppColorSchemeModifier: ViewModifier {
    @State private var prefersLightStatusBar = false

    func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, .light)
            .onPreferenceChange(LightStatusBarPreferenceKey.self) { prefersLightStatusBar = $0 }
            .preferredColorScheme(prefersLightStatusBar ? .dark : .light)
    }
}
