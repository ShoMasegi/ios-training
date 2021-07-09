import UIKit

@IBDesignable
final class RepositoryInfoView: UIView {
    enum ViewType {
        case `private`(_ isPrivate: Bool?)
        case language(_ language: String?)
        case issues(count: Int)
        case date(_ date: Date?)

        var title: String {
            switch self {
            case .private(let isPrivate):
                guard let isPrivate = isPrivate else { return "" }
                return isPrivate ? "Private" : "Public"
            case .language(let language):
                return language ?? "unknown"
            case .issues(let count):
                return "\(count.withComma ?? "0") issues"
            case .date(let date):
                guard let date = date else { return "" }
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                return formatter.string(from: date)
            }
        }

        var image: UIImage {
            switch self {
            case .private: return R.image.private()!
            case .language: return R.image.language()!
            case .issues: return R.image.issue()!
            case .date: return R.image.date()!
            }
        }
    }

    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    func setType(_ type: ViewType) {
        iconImageView.image = type.image
        label.text = type.title
    }

    private func setupSubviews() {
        guard let view = R.nib.repositoryInfoView.instantiate(withOwner: self).first as? UIView else {
            return
        }
        view.frame = bounds
        view.layer.borderColor = R.color.controlHilight()!.cgColor
        view.layer.borderWidth = 0.5
        addSubview(view)
    }
}
