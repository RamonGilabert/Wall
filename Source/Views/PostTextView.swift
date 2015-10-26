import UIKit

class PostTextView: UIView {

  lazy var text: UILabel = {
    let label = UILabel()
    return label
    }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(text)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  func configureView(text: String) {

  }

  // MARK: - Setup frames

  func setupFrames() {
    
  }
}
