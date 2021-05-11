import Nuke
import UIKit

final class EventTableViewCell: UITableViewCell {
    func event(_ event: Event) {
        label.text = event.type
        repositoryLabel.text = event.repo.name
        Nuke.loadImage(with: event.actor.avatarUrl, into: iconImageView)
    }

    @IBOutlet private var label: UILabel!
    @IBOutlet private var repositoryLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView! {
        didSet {
            iconImageView.clipsToBounds = true
            iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        }
    }
}
