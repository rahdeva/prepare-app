import SwiftUI

struct DetailTopicCard: View {
    let topicName: String
    let question: String
    let date: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(topicName)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color.green700)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.green100)
                .cornerRadius(20)

            Text(question)
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(Color.slate900)

            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .font(.caption)
                    .foregroundStyle(Color.gray400)

                Text(date)
                    .font(.caption)
                    .foregroundStyle(Color.gray500)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(16)
        .shadowPrimary()
    }
}

#Preview {
    DetailTopicCard(
        topicName: "Job Interview Basics",
        question: "Introduce yourself in a job interview",
        date: "Wednesday, April 15, 2026"
    )
    .padding(24)
    .background(Color.slate50)
}
