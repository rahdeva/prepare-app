import SwiftUI

struct SessionCard: View {
    let title: String
    let subtitle: String
    let date: Date
    let actualTimeSeconds: Int
    let targetTimeSeconds: Int
    let rating: Double
    let notes: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Text(LocalizedStringKey(title))
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.slate900)

                Spacer()

                Text(date, format: .dateTime.month(.abbreviated).day())
                    .font(.subheadline)
                    .foregroundStyle(Color.gray400)
            }

            Text(LocalizedStringKey(subtitle))
                .font(.subheadline)
                .foregroundStyle(Color.gray500)

            Spacer().frame(height: 4)

            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.subheadline)
                        .foregroundStyle(Color.green500)

                    Text(clock: actualTimeSeconds)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.green500)

                    Group {
                        Text(verbatim: "/")
                        Text(clock: targetTimeSeconds)
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color.gray400)
                }

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.subheadline)
                        .foregroundStyle(Color.amber400)

                    Text(rating, format: .number.precision(.fractionLength(1)))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.slate800)
                }
            }

            Spacer().frame(height: 4)

            HStack(spacing: 6) {
                Text(verbatim: "\u{1F4DD}")
                    .font(.caption)

                Text(notes)
                    .font(.caption)
                    .foregroundStyle(Color.gray500)
                    .lineLimit(2)
            }
        }
        .padding(16)
        .background(.white)
        .cornerRadius(16)
        .shadowPrimary()
    }
}

#Preview {
    SessionCard(
        title: "Job Interview",
        subtitle: "Tell me about yourself.",
        date: .now,
        actualTimeSeconds: 120,
        targetTimeSeconds: 150,
        rating: 4.0,
        notes: "Good flow, need to work on examples"
    )
    .padding(24)
    .background(Color.slate50)
}
