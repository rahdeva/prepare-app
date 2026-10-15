//
//  TimeChip.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct TimeChip: View {
    let seconds: Int
    let isSelected: Bool
    
    private var minutes: Int { seconds / 60 }
    private var remainder: Int { seconds % 60 }

    var body: some View {
        // Longer translations such as "1 mnt 30 dtk" don't fit a quarter-width chip,
        // so fall back to stacking minutes over seconds instead of squeezing the text.
        ViewThatFits(in: .horizontal) {
            Text(duration: seconds)
                .font(.subheadline)
                .lineLimit(1)

            if minutes > 0 && remainder > 0 {
                VStack(spacing: 0) {
                    Text(duration: minutes * 60)
                    Text(duration: remainder)
                }
                .font(.caption)
                .lineLimit(1)
            }
        }
        .fontWeight(isSelected ? .semibold : .regular)
        .minimumScaleFactor(0.8)
        .padding(.horizontal, 6)
        .frame(maxWidth: .infinity)
        .frame(height: 44)
            .background(.white)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.primaryColor : Color.clear, lineWidth: 2)
            }
            .shadowPrimary()
    }
}
