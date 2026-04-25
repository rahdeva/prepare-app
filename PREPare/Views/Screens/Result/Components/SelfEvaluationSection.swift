import SwiftUI

struct SelfEvaluationSection: View {
    @Binding var rating: Int
    @Binding var notes: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Self-Evaluation")
                .font(.system(size: 20, weight: .bold))
                .padding(.bottom, 4)

            VStack(spacing: 12) {
                Text("Rate your performance")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray800)
                    .fontWeight(.semibold)
                    .padding(.bottom, 4)

                StarRatingView(rating: $rating)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(16)
            .shadowPrimary()

            VStack(alignment: .leading, spacing: 8) {
                Text("Notes (Optional)")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray800)
                    .fontWeight(.semibold)

                TextField("What went well? What can you improve?", text: $notes, axis: .vertical)
                    .lineLimit(3...6)
                    .font(.subheadline)
                    .padding()
                    .background(Color.gray100)
                    .cornerRadius(12)
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .cornerRadius(16)
            .shadowPrimary()
        }
    }
}

#Preview {
    NavigationStack {
        ResultView(path: .constant(NavigationPath()))
    }
}
