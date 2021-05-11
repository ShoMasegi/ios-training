import UIKit

final class EventTableViewCell: UITableViewCell {
    func event(_ event: Event) {
        label.text = event.type
        repositoryLabel.text = event.repo.name
    }

    @IBOutlet private var label: UILabel!
    @IBOutlet private var repositoryLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
}
