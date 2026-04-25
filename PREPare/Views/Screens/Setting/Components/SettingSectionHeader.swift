//
//  SettingSectionHeader.swift
//  PREPare
//
//  Created by rahdeva on 25/04/26.
//
import SwiftUI

struct SettingSectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(Color.slate500)
    }
}
