import Foundation

struct User: Decodable {
    let id: Int64
    let login: String
    let name: String?
    let avatarUrl: URL
    let followers: Int
    let following: Int

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case avatarUrl = "avatar_url"
        case followers
        case following
    }
}
