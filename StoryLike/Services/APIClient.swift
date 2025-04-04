import Foundation

protocol APIClientProtocol {
    func fetchImages() async throws -> StoriesDataModel
}

enum APIEndpoint {
    case fetchImages

    var url: String {
        switch self {
        case .fetchImages:
            return "https://api.unsplash.com/photos"
        }
    }
}

final class APIClient: APIClientProtocol {

    func fetchImages() async throws -> StoriesDataModel {
        let endpoint = APIEndpoint.fetchImages.url
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = setupHeaders()

        let (data, response) = try await URLSession.shared.data(for: request)

        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        }

        guard
            let response = response as? HTTPURLResponse,
            response.statusCode == 200 else
        {
            throw URLError(.badServerResponse)
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(StoriesDataModel.self, from: data)
        } catch {
            throw URLError(.cannotDecodeRawData)
        }
    }

    // MARK: - Helpers

    private func setupHeaders() -> [String: String] {
        guard let apiKey = Bundle.main.infoDictionary?["ACCESS_KEY"] as? String else { return [:] }
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Client-ID \(apiKey)"
        return headers
    }
}
