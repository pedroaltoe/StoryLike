import Foundation
import class Combine.AnyCancellable

final class StoriesViewModel: ObservableObject {

    @Published var currentIndex: Int = 0
    @Published var progress: CGFloat = 0
    @Published var viewState: StoriesViewState

    private var repository: Repository
    private var timer: AnyCancellable?

    init() {
        viewState = .idle
        let apiClient = APIClient()
        repository = RepositoryBuilder.makeRepository(api: apiClient)
    }

    // MARK: Fetch data

    @MainActor func fetchImages() async {
        viewState = .loading
        do {
            let dataModel = try await repository.fetchImages()
            let displayModel = makeDisplayModel(dataModel)
            viewState = .present(displayModel)
            startTimer(displayModel)
        } catch {
            viewState = .error(error.localizedDescription)
        }
    }

    func onAppear() {
        Task {
            await fetchImages()
        }
    }

    func onRefresh() {
        Task {
            await fetchImages()
        }
    }

    // MARK: Actions

    /// Starts the timer to auto-advance stories
    private func startTimer(_ displayModel: StoriesDisplayModel) {
        timer?.cancel()
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateProgress(displayModel)
            }
    }

    /// Updates progress and switches to next story if needed
    private func updateProgress(_ displayModel: StoriesDisplayModel) {
        guard currentIndex < displayModel.stories.count else { return }

        if progress >= 1.0 {
            nextStory(displayModel)
        } else {
            progress += 0.1 / CGFloat(displayModel.stories[currentIndex].duration)
        }
    }

    /// Moves to the next story
    func nextStory(_ displayModel: StoriesDisplayModel) {
        if currentIndex < displayModel.stories.count - 1 {
            currentIndex += 1
            progress = 0
        } else {
            timer?.cancel() // Stop if last story
        }
    }

    /// Moves to the previous story
    func previousStory() {
        if currentIndex > 0 {
            currentIndex -= 1
            progress = 0
        }
    }

    /// Pauses the story when user holds
    func pauseStory() {
        timer?.cancel()
    }

    /// Resumes the timer when user releases
    func resumeStory(_ displayModel: StoriesDisplayModel) {
        startTimer(displayModel)
    }

    private func makeDisplayModel(_ dataModel: StoriesDataModel) -> StoriesDisplayModel {
        let stories = dataModel.compactMap {
            Story(id: $0.id, image: $0.urls.regular, duration: 3)
        }

        return StoriesDisplayModel(stories: stories)
    }
}
