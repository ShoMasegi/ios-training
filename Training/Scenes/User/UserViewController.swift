import UIKit

final class UserViewController: UIViewController {
    struct Dependency {
        var getUserUseCase: GetUserUseCase = GetUserDefaultUseCase()
        var getUserReposUseCase: GetUserReposUseCase = GetUserReposDefaultUseCase()
    }

    private enum Const {
        static let sectionIdentifier = "repositories"
    }

    private typealias TableViewDataSource = UITableViewDiffableDataSource<String, Repository>
    private typealias TableViewSnapshot = NSDiffableDataSourceSnapshot<String, Repository>

    // MARK: = Property

    @IBOutlet private var tableHeaderView: UserTableHeaderView!
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.register(R.nib.userRepositoryTableViewCell)
            tableView.register(
                UINib(resource: R.nib.userTableViewHeaderView),
                forHeaderFooterViewReuseIdentifier: R.nib.userTableViewHeaderView.name
            )
            tableView.dataSource = dataSource
            tableView.delegate = self
        }
    }

    private lazy var dataSource = TableViewDataSource(tableView: tableView) { tableView, indexPath, element in
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userRepositoryTableViewCell, for: indexPath)!
        cell.setRepository(element)
        return cell
    }

    private let dependency: Dependency
    private let username: String

    // MARK: - Initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private init(coder: NSCoder, dependency: Dependency, username: String) {
        self.dependency = dependency
        self.username = username
        super.init(coder: coder)!
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        fetchUserRepos()
    }
}

// MARK: - UITableViewDelegate

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UserTableViewHeaderView.height
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.dequeueReusableHeaderFooterView(withIdentifier: R.nib.userTableViewHeaderView.name)
    }
}

// MARK: - Private

extension UserViewController {
    private func fetchUser() {
        dependency.getUserUseCase.perform(username: username) { [weak self] result in
            switch result {
            case .success(let user):
                self?.tableHeaderView.setUser(user)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchUserRepos() {
        dependency.getUserReposUseCase.perform(username: username) { [weak self] result in
            switch result {
            case .success(let repos):
                self?.updateTableViewDataSet(repos: repos)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func updateTableViewDataSet(repos: [Repository]) {
        var snapshot = TableViewSnapshot()
        snapshot.appendSections([Const.sectionIdentifier])
        snapshot.appendItems(repos, toSection: Const.sectionIdentifier)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Instantiate

extension UserViewController {
    static func instantiate(dependency: Dependency = .init(), username: String) -> Self {
        R.storyboard.user().instantiateInitialViewController { coder in
            Self(coder: coder, dependency: dependency, username: username)
        }!
    }
}
