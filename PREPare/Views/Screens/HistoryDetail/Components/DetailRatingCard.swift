import SwiftUI

struct DetailRatingCard: View {
    let rating: Int
    let maxRating: Int = 5

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("YOUR RATING")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color.gray500)
                .tracking(0.5)

            HStack(spacing: 4) {
                ForEach(1...maxRating, id: \.self) { index in
                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .font(.system(size: 32))
                        .foregroundStyle(index <= rating ? Color.amber400 : Color.gray300)
                }
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
    DetailRatingCard(rating: 4)
        .padding(24)
        .background(Color.slate50)
}
