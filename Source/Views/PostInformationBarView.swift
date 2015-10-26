import UIKit

class PostInformationBarView: UIView {

  lazy var likesLabel: UILabel = {
    let label = UILabel()
    return label
    }()

  lazy var commentsLabel: UILabel = {
    let label = UILabel()
    return label
    }()

  lazy var seenLabel: UILabel = {
    let label = UILabel()
    return label
    }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    [likesLabel, commentsLabel, seenLabel].forEach { addSubview($0) }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  func configureView(likes: Int, comments: Int, seen: Int) {

  }

  // MARK: - Setup frames

  func setupFrames() {

  }
}
