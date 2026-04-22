//
//  TopicCard.swift
//  PREPare
//
//  Created by rahdeva on 22/04/26.
//

import SwiftUI

struct TopicCard: View {
    var title: String
    var isSelected: Bool = false
    
    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient.primaryGradient)
                .frame(width: 56, height: 56)
                .overlay {
                    Image(systemName: "ellipsis.message")
                        .foregroundStyle(.white)
                        .font(.title3)
                }
            
            Text(title)
                .fontWeight(isSelected ? .bold : .regular)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(16)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    isSelected ? Color.primaryColor : Color.clear,
                    lineWidth: 2
            )
        }
        .shadowPrimary()
    }
}
