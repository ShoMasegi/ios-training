import UIKit

final class UserRepositoryTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var starCountLabel: UILabel!

    func setRepository(_ repo: Repository) {
        nameLabel.text = repo.name
        descriptionLabel.text = repo.description
        starCountLabel.text = repo.stargazersCount.withComma
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        descriptionLabel.text = ""
        starCountLabel.text = ""
    }
}