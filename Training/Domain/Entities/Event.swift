import Foundation

struct Event: Decodable, Hashable {
    let id: String
    let type: String
    let actor: Actor
    let repo: RepositorySummary

    static func ==(lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    struct Actor: Decodable {
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
}
