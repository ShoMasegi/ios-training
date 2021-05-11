import UIKit

final class RepositoryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Repository"
    }
}

// MARK: - Instantiate

extension RepositoryViewController {
    static func instantiate() -> Self {
        R.storyboard.repository().instantiateInitialViewController()!
    }
}
