import UIKit
import Nuke

protocol RepositoryEventViewDelegate: AnyObject {
    func repositoryEventView(_ view: RepositoryEventView, didDetailButtonTapped: UIButton)
}

final class RepositoryEventView: UIView {
    @IBOutlet private var actorNameLabel: UILabel!
    @IBOutlet private var actorImageView: UIImageView! {
        didSet {
            actorImageView.layer.cornerRadius = actorImageView.frame.height / 2
        }
    }

    @IBOutlet private var eventLabel: UILabel!
    @IBOutlet private var eventBackgroundView: UIView! {
        didSet {
            eventBackgroundView.layer.cornerRadius = 3
        }
    }

    private weak var delegate: RepositoryEventViewDelegate?

    func setEvent(_ event: Event) {
        actorNameLabel.text = event.actor.login
        Nuke.loadImage(with: event.actor.avatarUrl, into: actorImageView)
        eventLabel.text = event.type
    }

    func setDelegate(_ delegate: RepositoryEventViewDelegate) {
        self.delegate = delegate
    }

    @IBAction private func detailButtonTouchUpInside(_ sender: UIButton) {
        delegate?.repositoryEventView(self, didDetailButtonTapped: sender)
    }
}
