//
//  SettingSectionHeader.swift
//  PREPare
//
//  Created by rahdeva on 25/04/26.
//
import SwiftUI

struct SettingSectionHeader: View {
    let title: LocalizedStringKey

    var body: some View {
        Text(title)
            .font(.system(size: 13, weight: .semibold))
            .tracking(0.6)
            .foregroundStyle(Color.slate500)
            .padding(.leading, 4)
    }
}

/// Rounded-square icon used at the start of every settings row.
struct SettingIcon: View {
    let systemName: String
    var isDestructive: Bool = false

    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: 17, weight: .medium))
            .foregroundStyle(isDestructive ? Color.red500 : Color.slate700)
            .frame(width: 44, height: 44)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(isDestructive ? Color.red50 : Color.slate100)
            )
    }
}

extension View {
    /// White card with a soft shadow shared by all settings rows.
    func settingCard() -> some View {
        self
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.slate900.opacity(0.06), radius: 10, x: 0, y: 4)
            )
    }
}
