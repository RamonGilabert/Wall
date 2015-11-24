import UIKit
import SDWebImage

public protocol PostMediaViewDelegate: class {

  func mediaDidTap(index: Int)
}

public class PostMediaView: UIView {

  public struct Dimensions {
    public static let containerOffset: CGFloat = 10
    public static let totalOffset: CGFloat = 20
    public static let height: CGFloat = ceil((UIScreen.mainScreen().bounds.width - 20) / 1.295)
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
    label.font = FontList.Post.media
    label.textColor = UIColor.whiteColor()
    label.textAlignment = .Center
    label.opaque = true
    label.backgroundColor = ColorList.Post.media

    return label
    }()

  public lazy var playButton: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: ImageList.Basis.playButton)
    imageView.frame = CGRectIntegral(CGRect(x: (UIScreen.mainScreen().bounds.width - 64 - Dimensions.totalOffset) / 2,
      y: (274 - 64) / 2, width: 64, height: 64))

    return imageView
    }()

  public weak var delegate: PostMediaViewDelegate?

  // MARK: - Initialization

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [firstImageView, secondImageView, thirdImageView, playButton].forEach {
      $0.contentMode = .ScaleAspectFill
      $0.clipsToBounds = true
      $0.backgroundColor = UIColor.whiteColor()
      $0.opaque = true
      $0.userInteractionEnabled = true
      $0.layer.drawsAsynchronously = true
    }

    playButton.backgroundColor = UIColor.clearColor()

    [firstTapGestureRecognizer, secondTapGestureRecognizer,
      thirdTapGestureRecognizer, fourthTapGestureRecognizer].forEach {
        $0.addTarget(self, action: "handleGestureRecognizer:")
    }

    firstImageView.addGestureRecognizer(firstTapGestureRecognizer)
    secondImageView.addGestureRecognizer(secondTapGestureRecognizer)
    thirdImageView.addGestureRecognizer(thirdTapGestureRecognizer)
    imagesCountLabel.addGestureRecognizer(fourthTapGestureRecognizer)

    firstImageView.addSubview(playButton)
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
    let totalWitdh = UIScreen.mainScreen().bounds.width
    let viewsArray = [firstImageView, secondImageView, thirdImageView]

    playButton.alpha = 0
    viewsArray.forEach { $0.removeFromSuperview() }

    for (index, element) in media.enumerate() where index < 3 {
      addSubview(viewsArray[index])
      viewsArray[index].sd_setImageWithURL(element.thumbnail,
        placeholderImage: UIImage(named: ImageList.Basis.placeholder))
    }

    switch media.count {
    case 1:
      firstImageView.frame = CGRectIntegral(CGRect(x: Dimensions.containerOffset, y: 0,
        width: totalWitdh - Dimensions.totalOffset, height: Dimensions.height))

      if let firstMedia = media.first where firstMedia.kind == .Video {
        playButton.alpha = 1
      }
    case 2:
      let imageSize = ceil((totalWitdh - Dimensions.totalOffset) / 2)

      firstImageView.frame = CGRectIntegral(CGRect(x: Dimensions.containerOffset, y: 0,
        width: imageSize - 5, height: Dimensions.height))

      secondImageView.frame = CGRectIntegral(CGRect(x: imageSize + 5 + Dimensions.containerOffset, y: 0,
        width: imageSize - 5, height: Dimensions.height))
    default:
      let smallImageSize = ceil((totalWitdh - Dimensions.totalOffset) / 3)
      let bigImageSize = ceil(smallImageSize * 2)
      let smallOffset = ceil(bigImageSize + 5 + Dimensions.containerOffset)

      firstImageView.frame = CGRectIntegral(CGRect(x: Dimensions.containerOffset, y: 0,
        width: bigImageSize - 5, height: Dimensions.height))

      secondImageView.frame = CGRectIntegral(CGRect(x: smallOffset, y: 0,
        width: smallImageSize - 5, height: Dimensions.height / 2 - 5))

      thirdImageView.frame = CGRectIntegral(CGRect(x: smallOffset, y: Dimensions.height / 2 + 5,
        width: smallImageSize - 5, height: Dimensions.height / 2 - 5))

      imagesCountLabel.frame = thirdImageView.bounds
      imagesCountLabel.text = "+\(media.count - 3)"
      imagesCountLabel.alpha = media.count > 3 ? 1 : 0
    }
  }
}
