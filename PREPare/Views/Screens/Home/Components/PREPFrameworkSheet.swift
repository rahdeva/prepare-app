import SwiftUI

struct PREPFrameworkSheet: View {
    @Environment(\.dismiss) private var dismiss

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
                ForEach(PREPStep.allCases) { step in
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
    let step: PREPStep

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                Text(verbatim: "\(step.letter) —")
                Text(step.title)
            }
            .fontWeight(.bold)
            Text(step.sheetDescription)
                .font(.subheadline)
            Text("Example:")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(step.sheetExample)
                .font(.subheadline)
                .italic()
        }
    }
}

#Preview {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            PREPFrameworkSheet()
        }
}
