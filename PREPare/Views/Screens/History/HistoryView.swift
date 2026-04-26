import SwiftUI

struct HistoryView: View {
    @Binding var path: NavigationPath

    private let sessions = [
        (
            title: "Job Interview Basics",
            subtitle: "Introduce yourself in a job interview",
            date: "Apr 15",
            actualTime: 120,
            targetTime: 150,
            rating: 4.0,
            notes: "Good flow, need to work on examples"
        ),
        (
            title: "Job Interview Basics",
            subtitle: "Introduce yourself in a job interview",
            date: "Apr 15",
            actualTime: 120,
            targetTime: 150,
            rating: 4.0,
            notes: "Good flow, need to work on examples"
        ),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ActivityHeatmapCard()

                Text("Recent Sessions")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.slate900)
                    .padding(.top, 8)

                ForEach(0..<sessions.count, id: \.self) { index in
                    let session = sessions[index]
                    Button {
                        path.append(AppRoute.historyDetail)
                    } label: {
                        SessionCard(
                            title: session.title,
                            subtitle: session.subtitle,
                            date: session.date,
                            actualTimeSeconds: session.actualTime,
                            targetTimeSeconds: session.targetTime,
                            rating: session.rating,
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
        .background(Color.slate50)
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HistoryView(path: .constant(NavigationPath()))
    }
}
