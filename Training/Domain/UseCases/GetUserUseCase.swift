import Foundation

protocol GetUserUseCase {
    func perform(username: String, completion: @escaping (Result<User, Error>) -> Void)
}

final class GetUserDefaultUseCase: GetUserUseCase {
    func perform(username: String, completion: @escaping (Result<User, Error>) -> Void) {
        let request = GetUserRequest(username: username)
        Network.request(request, completion: completion)
    }
}
