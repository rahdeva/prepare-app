import SwiftUI
import SwiftData

/// Opened from the streak card on Home: the practice heatmap with totals underneath.
struct PracticeActivityView: View {
    @Environment(HistoryViewModel.self) private var historyVM

    var body: some View {
        let stats = historyVM.stats

        ScrollView {
            VStack(spacing: 20) {
                ActivityHeatmapCard(stats: stats)
                ActivityStatsCard(stats: stats)
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)
            .padding(.bottom, 24)
        }
        .background(Color.slate50)
        .localizedNavigationTitle("Practice Activity")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { historyVM.fetchSessions() }
    }
}

#Preview {
    NavigationStack {
        PracticeActivityView()
            .environment(HistoryViewModel(modelContext: PreviewContainer.context))
    }
}
