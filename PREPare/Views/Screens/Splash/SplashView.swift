import SwiftUI

struct SplashScreenView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack{
            LinearGradient.primaryGradient
                .ignoresSafeArea()
            
            VStack(){
                ZStack{
                    Image("prepare_app_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .background(
                            RoundedRectangle(cornerRadius: 40)
                                .fill(.white)
                                .shadowPrimary()
                                .padding(24)
                        )
                }
                
                Text("PREPare")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
                withAnimation(.easeIn(duration: 0.2)){
                    isPresented.toggle()
                }
            })
        }
    }
}

#Preview {
    SplashScreenView(isPresented: .constant(true))
}
