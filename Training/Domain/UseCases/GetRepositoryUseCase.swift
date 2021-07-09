import Foundation

protocol GetRepositoryUseCase {
    func perform(repoName: String, completion: @escaping (Result<Repository, Error>) -> Void)
}

final class GetRepositoryDefaultUseCase: GetRepositoryUseCase {
    func perform(repoName: String, completion: @escaping (Result<Repository, Error>) -> Void) {
        let request = GetRepositoryRequest(repoName: repoName)
        Network.request(request, completion: completion)
    }
}
