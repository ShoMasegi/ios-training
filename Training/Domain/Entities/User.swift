import Foundation

struct User: Decodable {
    let id: Int64
    let login: String
    let displayLogin: String?
    let url: URL
    let avatarUrl: URL

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case displayLogin = "display_login"
        case url
        case avatarUrl = "avatar_url"
    }
}
