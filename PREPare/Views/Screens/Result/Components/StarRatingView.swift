import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int
    let maxRating: Int = 5

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .font(.system(size: 36))
                    .foregroundStyle(index <= rating ? Color.amber400 : Color.gray300)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}

#Preview {
    StarRatingView(rating: .constant(3))
}
