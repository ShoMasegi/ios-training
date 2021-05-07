import Alamofire
import Foundation

final class NetworkLogger: EventMonitor {
    func requestDidResume(_ request: Request) {
        guard let urlRequest = request.request,
              let method = urlRequest.httpMethod,
              let requestUrl = urlRequest.url?.absoluteString else { return }

        print(request.cURLDescription())
        print("🚀🚀🚀🚀🚀 [\(method)] '\(requestUrl)'")
        if let bodyData = urlRequest.httpBody, let body = String(data: bodyData, encoding: .utf8) {
            print("Body: \(body)")
        }
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        let requestDescription = request.request.map { "[\($0.httpMethod!)] '\($0)'" } ?? "nil"

        switch response.result {
        case .success:
            let responseDescription = response.response.map { res in
                """
                🏁🏁🏁🏁🏁 [\(String(res.statusCode))] \(requestDescription)'
                Headers: \(res.allHeaderFields.map { "\($0): \($1)" })
                Body: \(response.data.map { String(data: $0, encoding: .utf8)! } ?? "")
                """
            } ?? ""
            print(responseDescription)
        case .failure(let error):
            print("""
                  ⚠️⚠️⚠️⚠️⚠️ \(requestDescription)
                  \(error)
                  """)
        }
    }
}

