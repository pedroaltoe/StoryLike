import Foundation

enum StoriesViewState {
    case idle
    case loading
    case present(StoriesDisplayModel)
    case error(String)
    case empty
}
