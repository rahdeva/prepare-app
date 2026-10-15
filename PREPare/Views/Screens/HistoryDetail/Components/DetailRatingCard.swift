import SwiftUI

/// Shows the saved rating; stars become tappable only while the detail screen is in edit mode.
struct DetailRatingCard: View {
    @Binding var rating: Int
    let isEditing: Bool
    private let maxRating = 5

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("YOUR RATING")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color.gray500)
                .tracking(0.5)

            if isEditing {
                StarRatingView(rating: $rating)
            } else {
                HStack(spacing: 8) {
                    ForEach(1...maxRating, id: \.self) { index in
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .font(.system(size: 36))
                            .foregroundStyle(index <= rating ? Color.amber400 : Color.gray300)
                    }
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(Text("Rating \(rating) of \(maxRating)"))
            }

            if rating == 0 {
                Text("Not rated yet")
                    .font(.subheadline)
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
    @Previewable @State var rating = 3
    VStack(spacing: 16) {
        DetailRatingCard(rating: $rating, isEditing: false)
        DetailRatingCard(rating: $rating, isEditing: true)
    }
    .padding(24)
    .background(Color.slate50)
}
