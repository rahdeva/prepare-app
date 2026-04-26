import SwiftUI

struct DetailNotesCard: View {
    let notes: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("YOUR NOTES")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color.gray500)
                .tracking(0.5)

            Text(notes)
                .font(.body)
                .foregroundStyle(Color.slate800)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(16)
        .shadowPrimary()
    }
}

#Preview {
    DetailNotesCard(notes: "Good flow, need to work on examples")
        .padding(24)
        .background(Color.slate50)
}
