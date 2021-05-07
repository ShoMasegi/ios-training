import Combine
import Foundation

protocol GetEventsUseCase {
    func perform(page: Int, completion: @escaping (Result<[Event], Error>) -> Void)
    func perform(page: Int) -> AnyPublisher<[Event], Error>
}

final class GetEventsDefaultUseCase: GetEventsUseCase {
    func perform(page: Int, completion: @escaping (Result<[Event], Error>) -> Void) {
        let request = GetEventsRequest(page: page)
        Network.request(request, completion: completion)
    }

    func perform(page: Int) -> AnyPublisher<[Event], Error> {
        let request = GetEventsRequest(page: page)
        return Network.request(request)
    }
}