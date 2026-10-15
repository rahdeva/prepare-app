import SwiftUI
import SwiftData

struct HomeView: View {
    @State var showModalPREP: Bool = false
    @Binding var path: NavigationPath
    @Environment(HistoryViewModel.self) private var historyVM
    
    var body: some View {
        VStack {
            HStack(){
                ChipButton {
                    Button {
                        showModalPREP = true
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "lightbulb.circle.fill")
                            Text(verbatim: "PREP").fontWeight(.semibold)
                        }
                    }
                }
                Spacer()
//                ChipButton {
//                    Button {
//                        print("Tutorial tapped")
//                    } label: {
//                        HStack(spacing: 6) {
//                            Image(systemName: "info.circle.fill")
//                            Text("Tutorial").fontWeight(.semibold)
//                        }
//                    }
//                }
                ChipButton(
                    horizontalPadding: 8
                ){
                    Button {
                        path.append(AppRoute.settings)
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .accessibilityLabel(Text("Settings"))
                }
                
            }
            .padding(.horizontal, 24)
            .padding(.top, 12)
            .padding(.bottom, 24)
            
            ScrollView{
                let stats = historyVM.stats
                Button {
                    path.append(AppRoute.practiceActivity)
                } label: {
                    StreakCard(streak: stats.currentStreak, hasPracticedToday: stats.hasPracticedToday)
                }
                .buttonStyle(.plain)
                .accessibilityHint(Text("Shows your practice activity"))
                Spacer().frame(height: 20)

                StartPracticeCard(path: $path)
                Spacer().frame(height: 20)

                Button(
                    action: {
                        path.append(AppRoute.history)
                    },
                ){
                    HistoryCard()
                }
            }
        }
        .sheet(isPresented: $showModalPREP) {
            PREPFrameworkSheet()
        }
        .localizedNavigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        HomeView(path: .constant(NavigationPath()))
            .environment(HistoryViewModel(modelContext: PreviewContainer.context))
    }
}
