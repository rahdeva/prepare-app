import SwiftUI

struct OnboardingPage {
    let icon: String
    let iconColor: Color
    let iconBackgroundColor: Color
    let title: String
    let description: String
}

struct OnboardingView: View {
    @State private var currentPage = 0

    private let pages: [OnboardingPage] = [
        OnboardingPage(
            icon: "brain",
            iconColor: .blue600,
            iconBackgroundColor: .blue100,
            title: "Structure Your Thoughts",
            description: "Learn to organize your ideas using the proven PREP framework for clear and confident communication."
        ),
        OnboardingPage(
            icon: "clock",
            iconColor: .green600,
            iconBackgroundColor: .green100,
            title: "Time-Bound Practice",
            description: "Practice speaking with customizable time limits to simulate real-world spontaneous situations."
        ),
        OnboardingPage(
            icon: "chart.line.uptrend.xyaxis",
            iconColor: .purple600,
            iconBackgroundColor: .purple100,
            title: "Track Your Progress",
            description: "Build a consistent practice habit and track your improvement with self-evaluation and history."
        )
    ]

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                if currentPage < pages.count - 1 {
                    Button("Skip") {
                        withAnimation {
                            currentPage = pages.count - 1
                        }
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color.gray500)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .frame(height: 44)

            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    OnboardingPageContent(page: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 0.3), value: currentPage)

            PageIndicator(currentPage: currentPage, pageCount: pages.count)
                .padding(.bottom, 24)

            PrimaryButton(
                title: currentPage < pages.count - 1 ? "Next" : "Get Started",
                action: {
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    }
                }
            )
            .padding(.bottom, 32)
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }
}

private struct OnboardingPageContent: View {
    let page: OnboardingPage

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Circle()
                .fill(page.iconBackgroundColor)
                .frame(width: 160, height: 160)
                .overlay(
                    Image(systemName: page.icon)
                        .font(.system(size: 64, weight: .medium))
                        .foregroundStyle(page.iconColor)
                )

            Spacer()
                .frame(height: 40)

            Text(page.title)
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(Color.slate900)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            Spacer()
                .frame(height: 16)

            Text(page.description)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.gray500)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 32)

            Spacer()
        }
    }
}

private struct PageIndicator: View {
    let currentPage: Int
    let pageCount: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<pageCount, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? Color.slate800 : Color.slate300)
                    .frame(
                        width: index == currentPage ? 28 : 8,
                        height: 8
                    )
                    .animation(.easeInOut(duration: 0.3), value: currentPage)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
