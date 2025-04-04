import Foundation

struct RepositoryBuilder {
    static func makeRepository(api: APIClientProtocol)
    -> Repository {
        Repository {
            try await api.fetchImages()
        }
    }
}
