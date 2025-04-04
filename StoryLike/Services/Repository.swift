import Foundation

enum RepositoryError: Error {
    case failure
}

struct Repository {
    var fetchImages: () async throws -> StoriesDataModel

    init(fetchImages: @escaping () async throws -> StoriesDataModel) {
        self.fetchImages = fetchImages
    }
}
