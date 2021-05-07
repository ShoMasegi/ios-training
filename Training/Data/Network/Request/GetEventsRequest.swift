import Alamofire

struct GetEventsRequest: BaseRequest {
    typealias Response = [Event]
    var path: String = "/events"
    var method: HTTPMethod = .get
    var parameters: Parameters?

    init(page: Int) {
        parameters = ["page": page]
    }
}
