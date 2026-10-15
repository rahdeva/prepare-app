import SwiftUI

/// Shows the saved notes; turns into a text field only while the detail screen is in edit mode.
struct DetailNotesCard: View {
    @Binding var notes: String
    let isEditing: Bool
    var isFocused: FocusState<Bool>.Binding

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("YOUR NOTES")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color.gray500)
                .tracking(0.5)

            if isEditing {
                TextField("What went well? What can you improve?", text: $notes, axis: .vertical)
                    .lineLimit(3...6)
                    .font(.subheadline)
                    .foregroundStyle(Color.slate800)
                    .padding()
                    .background(Color.gray100)
                    .cornerRadius(12)
                    .focused(isFocused)
            } else if notes.isEmpty {
                Text("No notes added")
                    .font(.body)
                    .foregroundStyle(Color.gray400)
            } else {
                Text(notes)
                    .font(.body)
                    .foregroundStyle(Color.slate800)
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
    @Previewable @State var notes = "Good flow, need to work on examples"
    @Previewable @FocusState var isFocused: Bool
    VStack(spacing: 16) {
        DetailNotesCard(notes: $notes, isEditing: false, isFocused: $isFocused)
        DetailNotesCard(notes: $notes, isEditing: true, isFocused: $isFocused)
    }
    .padding(24)
    .background(Color.slate50)
}
