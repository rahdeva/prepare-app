import SwiftUI

struct SplashView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack{
            LinearGradient.primaryGradient
                .ignoresSafeArea()
            
            VStack(){
                Image("prepare_app_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .background(
                        RoundedRectangle(cornerRadius: 40)
                            .fill(.white)
                            .shadowPrimary()
                            .padding(.vertical, 4)
                    )
                    .shadowPrimary()
                
                Text("PREPare")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                withAnimation(.easeIn(duration: 0.2)){
                    isPresented.toggle()
                }
            })
        }
    }
}

#Preview {
    SplashView(isPresented: .constant(true))
}
