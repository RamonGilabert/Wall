import UIKit

class PostAuthorView: UIView {

  lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
    }()

  lazy var authorName: UILabel = {
    let label = UILabel()
    return label
    }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    [avatarImageView, authorName].forEach { addSubview($0) }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup frames

  func setupFrames() {

  }
}
