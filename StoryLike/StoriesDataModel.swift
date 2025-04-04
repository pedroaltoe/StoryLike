import Foundation

typealias StoriesDataModel = [StoryInfo]

struct StoryInfo: Codable {
    let id: String
    let urls: Urls
}

struct Urls: Codable {
    let regular: String
    var regularUrl: URL? {
        URL(string: regular)
    }
}
