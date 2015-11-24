import UIKit

public protocol PostActionBarViewDelegate: class {

  func likeButtonDidPress(liked: Bool)
  func commentButtonDidPress()
}

public class PostActionBarView: UIView {

  public struct Dimensions {
    public static let generalOffset: CGFloat = 10
    public static let separatorHeight: CGFloat = 0.5
  }

  public lazy var topSeparator: CALayer = {
    let layer = CALayer()
    layer.backgroundColor = ColorList.Basis.tableViewBackground.CGColor
    layer.opaque = true

    return layer
    }()

  public lazy var likeButton: UIButton = { [unowned self] in
    let button = UIButton(type: .Custom)
    button.setAttributedTitle(self.configureAttributes(true, liked: false), forState: .Normal)
    button.titleLabel?.font = FontList.Action.like
    button.addTarget(self, action: "likeButtonDidPress", forControlEvents: .TouchUpInside)

    return button
    }()

  public lazy var commentButton: UIButton = { [unowned self] in
    let button = UIButton(type: .Custom)
    button.setAttributedTitle(self.configureAttributes(false, liked: false), forState: .Normal)
    button.titleLabel?.font = FontList.Action.comment
    button.addTarget(self, action: "commentButtonDidPress", forControlEvents: .TouchUpInside)

    return button
    }()

  public weak var delegate: PostActionBarViewDelegate?
  public var liked = false

  // MARK: - Initialization

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [likeButton, commentButton].forEach {
      addSubview($0)
      $0.opaque = true
      $0.backgroundColor = UIColor.clearColor()
      $0.layer.drawsAsynchronously = true
      $0.subviews.first?.opaque = true
      $0.subviews.first?.backgroundColor = UIColor.whiteColor()
    }

    layer.addSublayer(topSeparator)
    backgroundColor = UIColor.whiteColor()
  }

  // MARK: - Setup

  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)

    let totalWidth = UIScreen.mainScreen().bounds.width

    topSeparator.frame = CGRectIntegral(CGRect(x: Dimensions.generalOffset, y: 0,
      width: totalWidth - Dimensions.generalOffset * 2, height: Dimensions.separatorHeight))
    likeButton.frame = CGRectIntegral(CGRect(x: Dimensions.generalOffset, y: Dimensions.separatorHeight,
      width: totalWidth / 2 - Dimensions.generalOffset, height: 43))
    commentButton.frame = CGRectIntegral(CGRect(x: totalWidth / 2, y: Dimensions.separatorHeight,
      width: totalWidth / 2 - Dimensions.generalOffset, height: 43))
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configureView(liked: Bool) {
    self.liked = liked
    likeButton.setAttributedTitle(configureAttributes(true, liked: liked), forState: .Normal)
  }

  public func configureAttributes(likes: Bool, liked: Bool) -> NSAttributedString {
    let text = likes ? NSLocalizedString("Like", comment: "") : NSLocalizedString("Comment", comment: "")
    let color = liked ? ColorList.Action.liked : ColorList.Action.like
    var image = likes ? ImageList.Action.likeButton : ImageList.Action.commentButton

    if liked {
      image = ImageList.Action.likedButton
    }

    let textAttachment = NSTextAttachment()
    textAttachment.image = UIImage(named: image)
    let attachmentAttributedString = NSAttributedString(attachment: textAttachment)
    let attributedString = NSMutableAttributedString(string: String(format: " %@", text))
    attributedString.insertAttributedString(attachmentAttributedString, atIndex: 0)
    attributedString.addAttribute(NSForegroundColorAttributeName,
      value: color, range: NSMakeRange(0, attributedString.length))

    if let image = textAttachment.image {
      textAttachment.bounds = CGRectIntegral(CGRect(x: 0, y: -2, width: image.size.width, height: image.size.height))
    }

    return attributedString
  }

  // MARK: - Actions

  public func likeButtonDidPress() {
    liked = !liked

    if liked {
      UIView.animateWithDuration(0.1, animations: {
        self.likeButton.transform = CGAffineTransformMakeScale(1.35, 1.35)
        }, completion: { _ in
          UIView.animateWithDuration(0.1, animations: {
            self.likeButton.transform = CGAffineTransformIdentity
          })
      })
    }

    delegate?.likeButtonDidPress(liked)
    configureView(liked)
  }

  public func commentButtonDidPress() {
    delegate?.commentButtonDidPress()
  }
}
