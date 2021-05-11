import UIKit

final class MainViewController: UIViewController {
    struct Dependency {
        var getEventsUseCase: GetEventsUseCase = GetEventsDefaultUseCase()
    }

    private enum Const {
        static let sectionIdentifier = "events"
    }

    private typealias TableViewDataSource = UITableViewDiffableDataSource<String, Event>
    private typealias TableViewSnapShot = NSDiffableDataSourceSnapshot<String, Event>

    // MARK: - Property

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.register(R.nib.eventTableViewCell)
            tableView.dataSource = dataSource
            tableView.delegate = self
            tableView.tableHeaderView = UIView(frame: .zero)
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }

    private lazy var dataSource = TableViewDataSource(tableView: tableView) { tableView, indexPath, element in
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.eventTableViewCell, for: indexPath)!
        cell.event(element)
        return cell
    }

    private let dependency: Dependency

    // MARK: - Initializer

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    private init(coder: NSCoder, dependency: Dependency) {
        self.dependency = dependency
        super.init(coder: coder)!
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Events"
        fetchEvents()
    }
}

// MARK: - Private

extension MainViewController {
    private func fetchEvents() {
        dependency.getEventsUseCase.perform(page: 1) { [weak self] result in
            switch result {
            case .success(let events):
                self?.updateTableViewDataSet(events: events)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func updateTableViewDataSet(events: [Event]) {
        var snapshot = TableViewSnapShot()
        snapshot.appendSections([Const.sectionIdentifier])
        snapshot.appendItems(events, toSection: Const.sectionIdentifier)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // TODO: Implement cell tap event
    }
}

// MARK: - Instantiate

extension MainViewController {
    static func instantiate(dependency: Dependency = .init()) -> Self {
        R.storyboard.main().instantiateInitialViewController { coder in
            Self(coder: coder, dependency: dependency)
        }!
    }
}
