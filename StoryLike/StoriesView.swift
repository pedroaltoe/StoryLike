import SwiftUI

struct StoriesView: View {
    
    @StateObject private var viewModel = StoriesViewModel()

    // MARK: Body

    var body: some View {
        switch viewModel.viewState {
        case .idle:
            progressView
                .onAppear(perform: viewModel.onAppear)
        case .loading:
            progressView
        case let .present(dataModel):
            content(dataModel)
        case let .error(error):
            errorView(error)
        case .empty:
            emptyView()
        }
    }

    // MARK: Loading

    @ViewBuilder var progressView: some View {
        ProgressView()
            .controlSize(.large)
            .padding()
            .accessibilityLabel(A11y.Stories.loading)
            .accessibilityIdentifier("Progress view")
    }

    // MARK: Content

    @ViewBuilder private func content(_ displayModel: StoriesDisplayModel) -> some View {
        ZStack {
            TabView(selection: $viewModel.currentIndex) {
                ForEach(displayModel.stories.indices, id: \.self) { index in
                    GeometryReader { geometry in
                        storyImage(index, displayModel)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }

    // MARK: Image

    @ViewBuilder func storyImage(_ index: Int, _ displayModel: StoriesDisplayModel) -> some View {
        CacheAsyncImage(url: displayModel.stories[index].image) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .tag(index)
                    .ignoresSafeArea()
                    .overlay(
                        VStack {
                            StoryProgressBarView(progress: viewModel.progress)
                                .frame(height: 5)
                                .padding(.horizontal)
                            Spacer()
                        }
                    )
                    .onLongPressGesture(perform: viewModel.pauseStory)
                    .gesture(
                        TapGesture()
                            .onEnded {
                                viewModel.nextStory(displayModel)
                            }
                    )
                    .gesture(
                        LongPressGesture()
                            .onEnded { _ in
                                viewModel.resumeStory(displayModel)
                            }
                    )
            default:
                Image(systemName: ImageConstants.placeHolder)
                    .font(.largeTitle)
            }
        }
    }

    // MARK: Error

    @ViewBuilder func errorView(_ error: String) -> some View {
        VStack(spacing: Space.medium) {
            Text(error.capitalizingFirstLetter())
                .font(.title3)

            refreshButton()
        }
    }

    // MARK: Empty

    @ViewBuilder func emptyView() -> some View {
        VStack(spacing: Space.medium) {
            Text(Localized.Stories.emptyMessage)
                .font(.title3)

            refreshButton()
        }
    }

    // MARK: Refresh button

    @ViewBuilder func refreshButton() -> some View {
        Button {
            viewModel.onRefresh()
        } label: {
            Text(Localized.Stories.refresh)
        }
        .buttonStyle(.borderedProminent)
        .font(.body)
        .accessibilityLabel(A11y.Stories.refreshButton)
        .accessibilityIdentifier("Refresh button")
    }
}
