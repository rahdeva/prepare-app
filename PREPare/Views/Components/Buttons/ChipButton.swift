import SwiftUI

//struct ChipButton: View {
//    var title: String? = nil
//    var icon: String
//    var action: (() -> Void)? = nil
//    var horizontalPadding: CGFloat = 12
//    var verticalPadding: CGFloat = 8
//    
//    var body: some View {
//        HStack(spacing: 6){
//            Image(systemName: icon)
//            if let title = title {
//                Text(title)
//                    .fontWeight(.semibold)
//            }
//        }
//        .padding(.horizontal, horizontalPadding)
//        .padding(.vertical, verticalPadding)
//        .background(.white)
//        .cornerRadius(35)
//        .shadowPrimary()
//    }
//}

import SwiftUI

struct ChipButton<Label: View>: View {
    
    let label: Label
    var horizontalPadding: CGFloat = 12
    var verticalPadding: CGFloat = 8
    
    init(
        horizontalPadding: CGFloat = 12,
        verticalPadding: CGFloat = 8,
        @ViewBuilder label: () -> Label
    ) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.label = label()
    }
    
    var body: some View {
        label
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(.white)
            .cornerRadius(35)
            .shadowPrimary()
            .buttonStyle(.plain)
    }
}

#Preview {
    ChipButton{
        Text("asdasd")
    }
}
