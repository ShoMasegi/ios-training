import UIKit
import Nuke

final class RepositoryViewController: UIViewController {
    struct Dependency {
        var getRepositoryUseCase: GetRepositoryUseCase = GetRepositoryDefaultUseCase()
    }

    // MARK: - Property

    private let dependency: Dependency
    private let event: Event

    @IBOutlet private var eventView: RepositoryEventView!
    @IBOutlet private var repositoryNameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        }
    }

    @IBOutlet private var starCountView: RepositoryCountView!
    @IBOutlet private var watchCountView: RepositoryCountView!
    @IBOutlet private var forkCountView: RepositoryCountView!
    @IBOutlet private var privateInfoView: RepositoryInfoView!
    @IBOutlet private var languageInfoView: RepositoryInfoView!
    @IBOutlet private var dateInfoView: RepositoryInfoView!
    @IBOutlet private var issuesInfoView: RepositoryInfoView!
    
    // MARK: - Initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private init(coder: NSCoder, event: Event, dependency: Dependency) {
        self.event = event
        self.dependency = dependency
        super.init(coder: coder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        fetchRepository()
    }
}

// MARK: - Private

extension RepositoryViewController {
    private func setupSubviews() {
        eventView.setEvent(event)
        starCountView.setCount(0, type: .star)
        watchCountView.setCount(0, type: .watch)
        forkCountView.setCount(0, type: .fork)
        privateInfoView.setType(.private(nil))
        languageInfoView.setType(.language(nil))
        dateInfoView.setType(.date(nil))
        issuesInfoView.setType(.issues(count: 0))
    }

    private func updateSubviews(with repository: Repository) {
        navigationItem.title = repository.name
        repositoryNameLabel.text = repository.fullName
        descriptionLabel.text = repository.description
        Nuke.loadImage(with: repository.owner.avatarUrl, into: avatarImageView)
        starCountView.setCount(repository.stargazersCount, type: .star)
        watchCountView.setCount(repository.watchersCount, type: .watch)
        forkCountView.setCount(repository.forksCount, type: .fork)
        privateInfoView.setType(.private(repository.private))
        languageInfoView.setType(.language(repository.language))
        dateInfoView.setType(.date(repository.updatedAt))
        issuesInfoView.setType(.issues(count: repository.openIssuesCount))
    }

    private func fetchRepository() {
        dependency.getRepositoryUseCase.perform(repoName: event.repo.name) { [weak self] result in
                switch result {
                case .success(let repository):
                    self?.updateSubviews(with: repository)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

// MARK: - Instantiate

extension RepositoryViewController {
    static func instantiate(event: Event, dependency: Dependency = .init()) -> Self {
        R.storyboard.repository().instantiateInitialViewController { coder in
            Self(coder: coder, event: event, dependency: dependency)
        }!
    }
}
