import Alamofire

struct GetRepositoryRequest: BaseRequest {
    typealias Response = Repository
    var path: String { "/repos/\(repoName)" }
    let method: HTTPMethod = .get
    private let repoName: String

    init(repoName: String) {
        self.repoName = repoName
    }
}