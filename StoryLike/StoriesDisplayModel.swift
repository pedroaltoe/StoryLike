import Foundation

struct StoriesDisplayModel: Identifiable {
    let id = UUID()
    let stories: [Story]
}

struct Story: Identifiable {
    let id: String
    let image: String
    let duration: TimeInterval
}
