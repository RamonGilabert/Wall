import UIKit
import Kingfisher

public class PostImagesView: UIView {

  public lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.frame = CGRect(x: 10, y: 0,
      width: UIScreen.mainScreen().bounds.width - 20, height: 274)
    imageView.contentMode = .ScaleAspectFill
    imageView.clipsToBounds = true

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
    if let image = images.first {
      imageView.kf_setImageWithURL(image)
    }
  }
}
