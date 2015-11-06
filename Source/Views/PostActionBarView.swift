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
    layer.backgroundColor = UIColor.grayColor().CGColor
    layer.opaque = true

    return layer
    }()

  public lazy var likeButton: UIButton = { [unowned self] in
    let button = UIButton(type: .Custom)
    button.setTitle(NSLocalizedString("Like", comment: ""), forState: .Normal)
    button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
    button.addTarget(self, action: "likeButtonDidPress", forControlEvents: .TouchUpInside)
    button.subviews.first?.opaque = true
    button.subviews.first?.backgroundColor = UIColor.whiteColor()

    return button
    }()

  public lazy var commentButton: UIButton = { [unowned self] in
    let button = UIButton(type: .Custom)
    button.setTitle(NSLocalizedString("Comment", comment: ""), forState: .Normal)
    button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
    button.addTarget(self, action: "commentButtonDidPress", forControlEvents: .TouchUpInside)
    button.setTitleColor(UIColor.grayColor(), forState: .Normal)
    button.subviews.first?.opaque = true
    button.subviews.first?.backgroundColor = UIColor.whiteColor()

    return button
    }()

  public weak var delegate: PostActionBarViewDelegate?

  // MARK: - Initialization

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [likeButton, commentButton].forEach {
      addSubview($0)
      $0.opaque = true
      $0.backgroundColor = UIColor.clearColor()
      $0.layer.drawsAsynchronously = true
    }

    layer.addSublayer(topSeparator)
    backgroundColor = UIColor.whiteColor()
  }

  // MARK: - Setup

  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)

    let totalWidth = UIScreen.mainScreen().bounds.width

    topSeparator.frame = CGRect(x: Dimensions.generalOffset, y: 0,
      width: totalWidth - Dimensions.generalOffset, height: Dimensions.separatorHeight)
    likeButton.frame = CGRect(x: Dimensions.generalOffset, y: Dimensions.separatorHeight,
      width: totalWidth / 2 - Dimensions.generalOffset, height: 43)
    commentButton.frame = CGRect(x: totalWidth / 2, y: Dimensions.separatorHeight,
      width: totalWidth / 2 - Dimensions.generalOffset, height: 43)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configureView(liked: Bool) {
    let color = liked ? UIColor.redColor() : UIColor.grayColor()
    likeButton.setTitleColor(color, forState: .Normal)
  }

  // MARK: - Actions

  public func likeButtonDidPress() {
    let color = likeButton.titleColorForState(.Normal) == UIColor.redColor()
      ? UIColor.grayColor() : UIColor.redColor()
    let liked = color == UIColor.redColor()

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
    likeButton.setTitleColor(color, forState: .Normal)
  }

  public func commentButtonDidPress() {
    delegate?.commentButtonDidPress()
  }
}
