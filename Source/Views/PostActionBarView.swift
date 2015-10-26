import UIKit

class PostActionBarView: UIView {

  lazy var topSeparator: UIView = {
    let view = UIView()
    return view
    }()

  lazy var likeButton: UIButton = {
    let button = UIButton()
    return button
    }()

  lazy var commentButton: UIButton = {
    let button = UIButton()
    return button
    }()

  lazy var bottomSeparator: UIView = {
    let view = UIView()
    return view
    }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    [topSeparator, likeButton, commentButton, bottomSeparator].forEach { addSubview($0) }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup frames

  func setupFrames() {

  }
}
