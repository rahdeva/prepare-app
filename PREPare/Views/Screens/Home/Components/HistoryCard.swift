import SwiftUI

struct HistoryCard: View {
    var body: some View {
        ZStack{
            CircleOrnament()
            
            HStack{
                VStack(alignment: .leading){
                    Text("My History")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                    
                    Spacer().frame(height: 4)
                    
                    Text("View your past activities and records.")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .fontWeight(.regular)
                }
                
                Spacer()
                
                Image(systemName: "book.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.white)
                
            }
            .padding(24)
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient.pinkGradient)
        )
        .padding(.horizontal, 24)
        .cornerRadius(24)
        .shadowPrimary()
    }
}
