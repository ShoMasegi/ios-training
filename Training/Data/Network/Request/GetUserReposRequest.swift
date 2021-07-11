import Alamofire

struct GetUserReposRequest: BaseRequest {
    typealias Response = [Repository]
    var path: String { "/users/\(username)/repos" }
    let method: HTTPMethod = .get
    private let username: String

    init(username: String) {
        self.username = username
    }
}
