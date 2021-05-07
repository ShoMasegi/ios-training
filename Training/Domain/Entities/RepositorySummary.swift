import Foundation

struct RepositorySummary: Decodable {
    let id: Int64
    let name: String
    let url: URL
}
