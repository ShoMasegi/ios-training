import Foundation

struct Event: Decodable, Hashable {
    let id: String
    let type: String
    let actor: User
    let repo: RepositorySummary

    static func ==(lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
