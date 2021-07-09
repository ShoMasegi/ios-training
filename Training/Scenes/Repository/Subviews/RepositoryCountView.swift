import UIKit

@IBDesignable
final class RepositoryCountView: UIView {
    enum ViewType {
        case star
        case watch
        case fork

        var title: String {
            switch self {
            case .star: return "Stargazers"
            case .watch: return "Watchers"
            case .fork: return "Forks"
            }
        }

        var image: UIImage {
            switch self {
            case .star: return R.image.star()!
            case .watch: return R.image.watch()!
            case .fork: return R.image.fork()!
            }
        }
    }

    @IBOutlet private var countLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    func setCount(_ count: Int, type: ViewType) {
        countLabel.text = count.withComma
        iconImageView.image = type.image
        titleLabel.text = type.title
    }

    private func setupSubviews() {
        guard let view = R.nib.repositoryCountView.instantiate(withOwner: self).first as? UIView else {
            return
        }
        view.frame = bounds
        view.layer.borderColor = R.color.controlHilight()!.cgColor
        view.layer.borderWidth = 0.5
        addSubview(view)
    }
}
