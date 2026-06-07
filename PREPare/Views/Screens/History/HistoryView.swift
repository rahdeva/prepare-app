import SwiftUI
import SwiftData

struct HistoryView: View {
    @Binding var path: NavigationPath
    @Environment(HistoryViewModel.self) private var historyVM

    var body: some View {
        Group {
            if historyVM.sessions.isEmpty {
                VStack(spacing: 16) {
                    Spacer()

                    Image(systemName: "clock.arrow.circlepath")
                        .font(.system(size: 48))
                        .foregroundStyle(Color.gray300)

                    Text("No Practice Sessions Yet")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.gray500)

                    Text("Complete a practice session to see your history here.")
                        .font(.subheadline)
                        .foregroundStyle(Color.gray400)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(historyVM.sessions) { session in
                            Button {
                                path.append(AppRoute.historyDetail(session))
                            } label: {
                                SessionCard(
                                    title: session.topicTitle,
                                    subtitle: session.questionText,
                                    date: session.formattedShortDate,
                                    actualTimeSeconds: session.totalTimeSeconds,
                                    targetTimeSeconds: session.targetTimeSeconds,
                                    rating: Double(session.rating),
                                    notes: session.notes
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }
            }
        }
        .background(Color.slate50)
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { historyVM.fetchSessions() }
    }
}

#Preview {
    NavigationStack {
        HistoryView(path: .constant(NavigationPath()))
            .environment(HistoryViewModel(modelContext: try! ModelContainer(configurations: ModelConfiguration(isStoredInMemoryOnly: true)).mainContext))
    }
}
