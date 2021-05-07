import UIKit

final class EventTableViewCell: UITableViewCell {
    func event(_ event: Event) {
        label.text = "\(event.type) by \(event.actor.login) at \(event.repo.name)"
    }

    @IBOutlet private var label: UILabel!
}
