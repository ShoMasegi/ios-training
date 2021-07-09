import Foundation

struct Repository: Decodable {
    let id: Int64
    let name: String
    let owner: Owner
    let `private`: Bool
    let updatedAt: Date
    let stargazersCount: Int
    let watchersCount: Int
    let openIssuesCount: Int
    let forksCount: Int
    let language: String?

    struct Owner: Decodable {
        let id: Int64
        let login: String
        let avatarUrl: URL

        enum CodingKeys: String, CodingKey {
            case id
            case login
            case avatarUrl = "avatar_url"
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case `private`
        case updatedAt = "updated_at"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case openIssuesCount = "open_issues_count"
        case forksCount = "forks_count"
        case language
    }
}
