//
//  TimeChip.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct TimeChip: View {
    let label: String
    let isSelected: Bool
    
    var body: some View {
        Text(label)
            .font(.subheadline)
            .fontWeight(isSelected ? .semibold : .regular)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.primaryColor : Color.clear, lineWidth: 2)
            }
            .shadowPrimary()
    }
}
