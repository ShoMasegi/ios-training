import Foundation

protocol GetUserReposUseCase {
    func perform(username: String, completion: @escaping (Result<[Repository], Error>) -> Void)
}

struct GetUserReposDefaultUseCase: GetUserReposUseCase {
    func perform(username: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        let request = GetUserReposRequest(username: username)
        Network.request(request, completion: completion)
    }
}
