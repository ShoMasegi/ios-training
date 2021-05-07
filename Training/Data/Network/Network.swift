import Alamofire
import Combine
import Foundation

final class Network {
    private enum Const {
        static let acceptableStatusCode = 200 ..< 300
        static let acceptableContentType = ["application/json"]
    }

    @discardableResult
    static func request<Request, Response>(
        _ request: Request,
        completion: @escaping (Result<Response, Error>) -> Void
    ) -> DataRequest where Request: BaseRequest, Response == Request.Response {
        afRequest(request).responseDecodable(of: Response.self) { response in
            switch response.result {
            case .success(let decoded): completion(.success(decoded))
            case .failure(let error): completion(.failure(error))
            }
        }
    }

    static func request<Request, Response>(_ request: Request) -> AnyPublisher<Response, Error>
        where Request: BaseRequest, Response == Request.Response {
        DataResponsePublisher<Response>(afRequest(request), queue: .main, serializer: DecodableResponseSerializer())
            .tryMap { response in
                switch response.result {
                case .success(let decoded): return decoded
                case .failure(let error): throw error
                }
            }.eraseToAnyPublisher()
    }

    // MARK: - Private

    private static var session = Session(eventMonitors: [NetworkLogger()])

    private static func afRequest<Request: BaseRequest>(_ request: Request) -> DataRequest {
        session.request(request)
            .validate(contentType: Const.acceptableContentType)
            .validate(statusCode: Const.acceptableStatusCode)
    }
}
