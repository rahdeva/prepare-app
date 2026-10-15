import SwiftUI

struct DetailTopicCard: View {
    let topicName: String
    let question: String
    let date: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(LocalizedStringKey(topicName))
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color.green700)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.green100)
                .cornerRadius(20)

            Text(LocalizedStringKey(question))
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(Color.slate900)

            HStack(spacing: 14) {
                HStack(spacing: 6) {
                    Image(systemName: "calendar")
                        .foregroundStyle(Color.gray400)

                    Text(date, format: .dateTime.weekday(.wide).day().month(.wide).year())
                        .foregroundStyle(Color.gray500)
                }

                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .foregroundStyle(Color.gray400)

                    Text(date, format: .dateTime.hour().minute())
                        .foregroundStyle(Color.gray500)
                }
            }
            .font(.caption)
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
        topicName: "Job Interview",
        question: "Tell me about yourself.",
        date: .now
    )
    .padding(24)
    .background(Color.slate50)
}
