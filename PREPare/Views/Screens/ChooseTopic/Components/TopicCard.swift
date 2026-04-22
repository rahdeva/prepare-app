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
                .fill(.blue.gradient)
                .frame(width: 80, height: 80)
                .overlay {
                    Image(systemName: "bubble.left.and.bubble.right")
                        .foregroundStyle(.white)
                        .font(.title2)
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
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)  // ← border kalau selected
        }
        .shadow(color: .black.opacity(0.08), radius: 8)
    }
}
