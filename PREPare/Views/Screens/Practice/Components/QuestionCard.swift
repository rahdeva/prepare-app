import SwiftUI

struct QuestionCard: View {
    let topic: String
    let question: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "ellipsis.message")
                    .font(.title2)
                    .foregroundStyle(.white)
                
                VStack(alignment: .leading, spacing: 1) {
                    Text("Question")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text("Topic: \(topic)")
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            
            Divider()
                .background(.white)
            
            Text(question)
                .font(.system(size: 32))
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .stroke(.white, lineWidth: 0.4)
        )
        .shadowPrimary()
    }
}

#Preview {
    NavigationStack {
        PracticeView(path: .constant(NavigationPath()))
    }
}

