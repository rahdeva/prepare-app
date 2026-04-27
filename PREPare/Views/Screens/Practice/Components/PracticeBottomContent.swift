import SwiftUI

struct PracticeBottomContent: View {
    let timeElapsed: Int
    let targetSeconds: Int
    let formatTime: (Int) -> String
    let onNext: () -> Void
    let isLast: Bool
    
    var isOverTime: Bool {
        timeElapsed > targetSeconds
    }
    
    var timerColor: Color {
        isOverTime ? .errorColor : .successColor
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 6) {
                Circle()
                    .fill(Color.primaryColor)
                    .frame(width: 8, height: 8)

                Text(formatTime(timeElapsed))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.primaryColor)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(timerColor)
            .cornerRadius(20)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 20)

            RecordingIndicatorCard()

            isLast
            ?   PrimaryButton(
                    title: "FINISH",
                    action: onNext,
                    bgColor: Color.successColor,
                    textColor: Color.primaryColor
                )
            :   PrimaryButton(
                    title: "NEXT",
                    action: onNext
                )
        }
    }
}

#Preview {
    NavigationStack {
        PracticeView(path: .constant(NavigationPath()))
    }
}
