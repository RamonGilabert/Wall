import UIKit

class PostImagesView: UIView {

  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
    }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(imageView)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup frames

  func setupFrames() {

  }
}
