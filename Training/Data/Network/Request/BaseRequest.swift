import Alamofire
import Foundation

protocol BaseRequest: URLRequestConvertible {
    associatedtype Response: Decodable
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
}

extension BaseRequest {
    var baseUrl: URL { URL(string: "https://api.github.com")! }
    var headers: [String: String] { [:] }
    var parameters: Parameters? { nil }
    var encoding: ParameterEncoding {
        switch method {
        case .post, .put, .patch: return JSONEncoding()
        default: return URLEncoding()
        }
    }

    var defaultHeaders: [String: String] {
        ["Accept": "application/vnd.github.v3+json"]
    }
}

// MARK: - URLRequestConvertible

extension BaseRequest {
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: baseUrl.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers.merging(defaultHeaders, uniquingKeysWith: +)
        request.timeoutInterval = TimeInterval(60)
        if let params = parameters {
            request = try encoding.encode(request, with: params)
        }
        return request
    }
}
