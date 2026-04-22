import SwiftUI

struct HomeView: View {
    @State var showModalPREP: Bool = false
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            HStack(){
                ChipButton {
                    Button {
                        showModalPREP = true
                        print("PREP tapped")
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "lightbulb.circle.fill")
                            Text("PREP").fontWeight(.semibold)
                        }
                    }
                }
                Spacer()
                ChipButton {
                    Button {
                        print("Tutorial tapped")
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "info.circle.fill")
                            Text("Tutorial").fontWeight(.semibold)
                        }
                    }
                }
                ChipButton {
                    Button {
                        path.append(AppRoute.settings)
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
                
            }
            .padding(.horizontal, 24)
            .padding(.top, 12)
            .padding(.bottom, 24)
            
            ScrollView{
                StreakCard()
                Spacer().frame(height: 20)
                
                StartPracticeCard(path: $path)
                Spacer().frame(height: 20)
                
                Button(
                    action: {
                        print("asdasds")
                        path.append(AppRoute.history)
                    },
                ){
                    HistoryCard()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(path: .constant(NavigationPath()))
    }
}
