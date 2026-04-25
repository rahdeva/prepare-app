import SwiftUI

struct PREPFrameworkSheet: View {
    @Environment(\.dismiss) private var dismiss

    private let steps: [(letter: String, title: String, description: String, example: String)] = [
        (
            letter: "P",
            title: "Point",
            description: "State your main opinion.",
            example: "I think morning exercise is important."
        ),
        (
            letter: "R",
            title: "Reason",
            description: "Explain the reason behind your opinion.",
            example: "Because exercise can make the body healthier and more refreshed."
        ),
        (
            letter: "E",
            title: "Example",
            description: "Give a simple example.",
            example: "For example, when I go jogging in the morning, I feel more focused while working."
        ),
        (
            letter: "P",
            title: "Point",
            description: "Repeat your main opinion as a closing.",
            example: "So, I believe morning exercise is very beneficial."
        ),
    ]

    @State private var contentHeight: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("PREP Framework")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(Color.gray500)
                        .frame(width: 32, height: 32)
                        .background(Color.gray100)
                        .clipShape(Circle())
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 16)

            Text("PREP helps you express your opinion clearly.")
                .font(.subheadline)
                .padding(.bottom, 8)

            HStack(spacing: 4) {
                Text("Formula:")
                    .fontWeight(.semibold)
                Text("Point → Reason → Example → Point")
            }
            .font(.subheadline)
            .padding(.bottom, 16)

            VStack(alignment: .leading, spacing: 16) {
                ForEach(steps, id: \.title) { step in
                    PREPStepRow(step: step)
                }
            }
        }
        .padding(24)
        .background(
            GeometryReader { geo in
                Color.clear.preference(key: SheetHeightKey.self, value: geo.size.height)
            }
        )
        .onPreferenceChange(SheetHeightKey.self) { contentHeight = $0 }
        .frame(maxWidth: .infinity, alignment: .top)
        .background(Color.white)
        .presentationDetents([.height(contentHeight)])
        .presentationDragIndicator(.visible)
    }
}

private struct SheetHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

private struct PREPStepRow: View {
    let step: (letter: String, title: String, description: String, example: String)

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(step.letter) — \(step.title)")
                .fontWeight(.bold)
            Text(step.description)
                .font(.subheadline)
            Text("Example: ")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(step.example)
                .font(.subheadline)
                .italic()
        }
    }
}

#Preview {
    Text("Home")
        .sheet(isPresented: .constant(true)) {
            PREPFrameworkSheet()
        }
}
