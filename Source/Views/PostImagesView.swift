import UIKit

public class PostImagesView: UIView {

  public lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
    }()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(imageView)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public func configureView(images: [NSURL]) {

  }

  // MARK: - Setup frames

  public func setupFrames() {

  }
}
