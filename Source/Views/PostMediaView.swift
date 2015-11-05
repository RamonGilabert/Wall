import UIKit
import SDWebImage

public protocol PostMediaViewDelegate: class {

  func mediaDidTap(index: Int)
}

public class PostMediaView: UIView {

  public struct Dimensions {
    public static let containerOffset: CGFloat = 10
    public static let totalOffset: CGFloat = 20
    public static let height: CGFloat = 274
  }

  public lazy var firstImageView = UIImageView()
  public lazy var secondImageView = UIImageView()
  public lazy var thirdImageView = UIImageView()
  public lazy var firstTapGestureRecognizer = UITapGestureRecognizer()
  public lazy var secondTapGestureRecognizer = UITapGestureRecognizer()
  public lazy var thirdTapGestureRecognizer = UITapGestureRecognizer()
  public lazy var fourthTapGestureRecognizer = UITapGestureRecognizer()

  public lazy var imagesCountLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFontOfSize(36)
    label.textColor = UIColor.whiteColor()
    label.textAlignment = .Center
    label.opaque = true
    label.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.35)

    return label
    }()

  public weak var delegate: PostMediaViewDelegate?

  // MARK: - Initialization

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [firstImageView, secondImageView, thirdImageView].forEach {
      $0.contentMode = .ScaleAspectFill
      $0.clipsToBounds = true
      $0.backgroundColor = UIColor.lightGrayColor()
      $0.opaque = true
    }

    [firstTapGestureRecognizer, secondTapGestureRecognizer,
      thirdTapGestureRecognizer, fourthTapGestureRecognizer].forEach {
        $0.addTarget(self, action: "handleGestureRecognizer:")
    }

    thirdImageView.addSubview(imagesCountLabel)
    backgroundColor = UIColor.whiteColor()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Actions

  public func handleGestureRecognizer(gesture: UITapGestureRecognizer) {
    var index = 2
    if gesture == firstTapGestureRecognizer {
      index = 0
    } else if gesture == secondTapGestureRecognizer {
      index = 1
    }

    delegate?.mediaDidTap(index)
  }

  // MARK: - Setup

  public func configureView(media: [Media]) {
    [firstImageView, secondImageView, thirdImageView].forEach { $0.removeFromSuperview() }
    
    switch media.count {
    case 1:
      addSubview(firstImageView)
      firstImageView.sd_setImageWithURL(media[0].thumbnail)
      firstImageView.frame = CGRect(x: Dimensions.containerOffset, y: 0,
        width: UIScreen.mainScreen().bounds.width - Dimensions.totalOffset,
        height: Dimensions.height)
    case 2:
      [firstImageView, secondImageView].forEach { addSubview($0) }
      firstImageView.sd_setImageWithURL(media[0].thumbnail)
      secondImageView.sd_setImageWithURL(media[1].thumbnail)
      firstImageView.frame = CGRect(x: Dimensions.containerOffset, y: 0,
        width: (UIScreen.mainScreen().bounds.width - Dimensions.totalOffset) / 2 - 5,
        height: Dimensions.height)

      secondImageView.frame = CGRect(x: (UIScreen.mainScreen().bounds.width - Dimensions.totalOffset) / 2 + 5 + Dimensions.containerOffset, y: 0,
        width: (UIScreen.mainScreen().bounds.width - Dimensions.totalOffset) / 2 - 5,
        height: Dimensions.height)
    default:
      [firstImageView, secondImageView, thirdImageView].forEach { addSubview($0) }
      firstImageView.sd_setImageWithURL(media[0].thumbnail)
      secondImageView.sd_setImageWithURL(media[1].thumbnail)
      thirdImageView.sd_setImageWithURL(media[2].thumbnail)

      firstImageView.frame = CGRect(x: Dimensions.containerOffset, y: 0,
        width: (UIScreen.mainScreen().bounds.width - Dimensions.totalOffset) * 2 / 3 - 5,
        height: Dimensions.height)

      secondImageView.frame = CGRect(x: (UIScreen.mainScreen().bounds.width - Dimensions.totalOffset) * 2 / 3 + 5 + Dimensions.containerOffset, y: 0,
        width: (UIScreen.mainScreen().bounds.width - Dimensions.totalOffset) / 3 - 5,
        height: Dimensions.height / 2 - 5)

      thirdImageView.frame = CGRect(x: (UIScreen.mainScreen().bounds.width - Dimensions.totalOffset) * 2 / 3 + 5 + Dimensions.containerOffset, y: Dimensions.height / 2 + 5,
        width: (UIScreen.mainScreen().bounds.width - Dimensions.totalOffset) / 3 - 5,
        height: Dimensions.height / 2 - 5)

      imagesCountLabel.frame = thirdImageView.bounds

      if media.count > 3 {
        imagesCountLabel.alpha = 1
        imagesCountLabel.text = "+\(media.count - 3)"
      } else {
        imagesCountLabel.alpha = 0
      }
    }
  }
}
