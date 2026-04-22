import SwiftUI

struct CircleOrnament: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Circle()
                    .fill(.white.opacity(0.15))
                    .frame(width: 100, height: 100)
                    .offset(x: 60, y: -60)
            }
            Spacer()
        }
        
        VStack {
            Spacer()
            HStack {
                Circle()
                    .fill(.white.opacity(0.15))
                    .frame(width: 100, height: 100)
                    .offset(x: -60, y: 60)
                Spacer()
            }
        }
    }
}
