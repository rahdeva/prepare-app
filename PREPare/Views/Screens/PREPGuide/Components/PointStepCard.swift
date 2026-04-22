//
//  PointStepCard.swift
//  PREPare
//
//  Created by rahdeva on 23/04/26.
//

import SwiftUI

struct PointStepCard: View {
    let step: (letter: String, title: String, subtitle: String, example: String)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Text(step.letter)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient.primaryGradient)
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(step.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(step.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            Text(step.example)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
        }
        .padding(16)
        .background(.white)
        .cornerRadius(16)
        .shadowPrimary()
    }
}
