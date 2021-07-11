import Nuke
import UIKit

final class UserTableHeaderView: UIView {
    @IBOutlet private var displayNameLabel: UILabel!
    @IBOutlet private var loginNameLabel: UILabel!
    @IBOutlet private var followersLabel: UILabel!
    @IBOutlet private var followingLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView! {
        didSet {
            iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        }
    }

    func setUser(_ user: User) {
        displayNameLabel.text = user.name ?? user.login
        loginNameLabel.text = user.login
        followersLabel.text = String(user.followers)
        followingLabel.text = String(user.following)
        Nuke.loadImage(with: user.avatarUrl, into: iconImageView)
    }
}
