import SwiftUI

struct SessionCard: View {
    let title: String
    let subtitle: String
    let date: Date
    let actualTimeSeconds: Int
    let targetTimeSeconds: Int
    let rating: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey(title))
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color.slate900)

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

            Divider()
                .padding(.vertical, 4)

            // When the session was practiced, formatted for the in-app language.
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                Text(date, format: .dateTime.weekday(.abbreviated).day().month(.abbreviated).year().hour().minute())
            }
            .font(.caption)
            .foregroundStyle(Color.gray500)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
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
        rating: 4.0
    )
    .padding(24)
    .background(Color.slate50)
}
