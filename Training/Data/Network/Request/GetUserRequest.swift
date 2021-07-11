import Alamofire

struct GetUserRequest: BaseRequest {
    typealias Response = User
    var path: String { "/users/\(username)" }
    let method: HTTPMethod = .get
    private let username: String

    init(username: String) {
        self.username = username
    }
}