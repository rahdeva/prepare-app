import SwiftUI

struct StreakCard: View {
    var body: some View {
        ZStack{
            CircleOrnament()
            
            HStack{
                HStack(alignment: .bottom){
                    Text("7")
                        .font(.system(size: 60))
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                    
                    Text("days Streak")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .offset(y: -12)
                }
                
                Spacer()
                
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "flame.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundStyle(Color(UIColor(hex: "#FFCF3E")))
                    
                    Image(systemName: "sparkles")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundStyle(Color(UIColor(hex: "#FFCF3E")))
                        .offset(x: 15, y: -15)
                }
                .frame(width: 100, height: 100)
                
            }
            .padding(24)
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient.orangeGradient)
        )
        .padding(.horizontal, 24)
        .cornerRadius(24)
        .shadowPrimary()
    }
}
