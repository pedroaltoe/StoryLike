import Foundation

typealias StoriesDataModel = [StoryImage]

// MARK: - StoryImage
struct StoryImage: Codable {
    let slug, color: String
    let likes: Int
    let assetType: String
    let updatedAt: String
    let links: StoriesDataModelLinks
    let id: String
    let topicSubmissions: TopicSubmissions
    let likedByUser: Bool
    let user: User
    let alternativeSlugs: AlternativeSlugs
    let promotedAt: String?
    let height, width: Int
    let breadcrumbs: [String]
    let urls: Urls
    let currentUserCollections: [String]
    let createdAt: String
    let blurHash, altDescription: String
    let sponsorship, description: String?

    enum CodingKeys: String, CodingKey {
        case slug, color, likes
        case assetType = "asset_type"
        case updatedAt = "updated_at"
        case links, id
        case topicSubmissions = "topic_submissions"
        case likedByUser = "liked_by_user"
        case user
        case alternativeSlugs = "alternative_slugs"
        case promotedAt = "promoted_at"
        case height, width, breadcrumbs, urls
        case currentUserCollections = "current_user_collections"
        case createdAt = "created_at"
        case blurHash = "blur_hash"
        case altDescription = "alt_description"
        case sponsorship, description
    }
}

// MARK: - AlternativeSlugs
struct AlternativeSlugs: Codable {
    let fr, ko, pt, it: String
    let de, es, en, ja: String
}

// MARK: - StoriesDataModelLinks
struct StoriesDataModelLinks: Codable {
    let downloadLocation, linksSelf, html, download: String

    enum CodingKeys: String, CodingKey {
        case downloadLocation = "download_location"
        case linksSelf = "self"
        case html, download
    }
}

// MARK: - TopicSubmissions
struct TopicSubmissions: Codable {
    let fashionBeauty: FashionBeauty

    enum CodingKeys: String, CodingKey {
        case fashionBeauty = "fashion-beauty"
    }
}

// MARK: - FashionBeauty
struct FashionBeauty: Codable {
    let status: String
    let approvedOn: String

    enum CodingKeys: String, CodingKey {
        case status
        case approvedOn = "approved_on"
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, thumb, smallS3: String
    let regular, small: String

    enum CodingKeys: String, CodingKey {
        case raw, full, thumb
        case smallS3 = "small_s3"
        case regular, small
    }
}

// MARK: - User
struct User: Codable {
    let profileImage: ProfileImage
    let location: String?
    let updatedAt: String
    let twitterUsername: String?
    let totalCollections: Int
    let lastName: String
    let bio: String?
    let name: String
    let links: UserLinks
    let totalLikes, totalPhotos, totalIllustrations: Int
    let id: String
    let totalPromotedPhotos: Int
    let forHire: Bool
    let social: Social
    let portfolioURL: String?
    let acceptedTos: Bool
    let firstName, instagramUsername: String
    let totalPromotedIllustrations: Int
    let username: String

    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
        case location
        case updatedAt = "updated_at"
        case twitterUsername = "twitter_username"
        case totalCollections = "total_collections"
        case lastName = "last_name"
        case bio, name, links
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case totalIllustrations = "total_illustrations"
        case id
        case totalPromotedPhotos = "total_promoted_photos"
        case forHire = "for_hire"
        case social
        case portfolioURL = "portfolio_url"
        case acceptedTos = "accepted_tos"
        case firstName = "first_name"
        case instagramUsername = "instagram_username"
        case totalPromotedIllustrations = "total_promoted_illustrations"
        case username
    }
}

// MARK: - UserLinks
struct UserLinks: Codable {
    let photos, likes, portfolio, linksSelf: String
    let html: String

    enum CodingKeys: String, CodingKey {
        case photos, likes, portfolio
        case linksSelf = "self"
        case html
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, large, medium: String
}

// MARK: - Social
struct Social: Codable {
    let instagramUsername: String
    let paypalEmail, portfolioURL, twitterUsername: String?

    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case paypalEmail = "paypal_email"
        case portfolioURL = "portfolio_url"
        case twitterUsername = "twitter_username"
    }
}
