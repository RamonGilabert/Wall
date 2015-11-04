import UIKit
import SDWebImage

public class PostImagesView: UIView {

  public struct Dimensions {
    public static let containerOffset: CGFloat = 10
    public static let totalOffset: CGFloat = 20
    public static let height: CGFloat = 274
  }

  public lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .ScaleAspectFill
    imageView.clipsToBounds = true
    imageView.backgroundColor = UIColor.lightGrayColor()

    return imageView
    }()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(imageView)
    imageView.opaque = true

    backgroundColor = UIColor.whiteColor()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public func configureView(images: [NSURL]) {
    if let image = images.first {
      imageView.sd_setImageWithURL(image)
    }

    imageView.frame = CGRect(x: Dimensions.containerOffset, y: 0,
      width: UIScreen.mainScreen().bounds.width - Dimensions.totalOffset,
      height: Dimensions.height)
  }
}
