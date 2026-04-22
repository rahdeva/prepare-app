import SwiftUI

struct StartPracticeCard: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        ZStack{
            CircleOrnament()
            
            VStack(alignment: .leading){
                Text("Practice with PREP")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                
                Spacer().frame(height: 24)
                
                Text("Choose a topic, set your time, and start practicing with the framework")
                    .font(.body)
                    .foregroundStyle(.white)
                
                Spacer().frame(height: 24)
                Button(
                    action: {
                        path.append(AppRoute.chooseTopic)
                    }
                ) {
                    HStack(spacing: 8) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 18, weight: .semibold))
                        
                        Text("Start Practice")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .foregroundStyle(Color.primaryColor)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.white)
                    .cornerRadius(16)
                    .shadowPrimary()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(alignment: .leading)
            .padding(24)
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(LinearGradient.primaryGradient)
        )
        .padding(.horizontal, 24)
        .cornerRadius(24)
        .shadowPrimary()
    }
}
