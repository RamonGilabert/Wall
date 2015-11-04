import UIKit

public protocol PostInformationBarViewDelegate: class {

  func likesInformationButtonDidPress()
  func commentInformationButtonDidPress()
  func seenInformationButtonDidPress()
}

public class PostInformationBarView: UIView {

  public struct Dimensions {
    public static let offset: CGFloat = 20
    public static let topOffset: CGFloat = 18
    public static let interitemOffset: CGFloat = 10
  }

  public lazy var likesButton: UIButton = { [unowned self] in
    let button = UIButton()
    button.titleLabel?.font = UIFont.systemFontOfSize(12)
    button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    button.addTarget(self, action: "likesButtonDidPress", forControlEvents: .TouchUpInside)

    return button
    }()

  public lazy var commentButton: UIButton = { [unowned self] in
    let button = UIButton()
    button.titleLabel?.font = UIFont.systemFontOfSize(12)
    button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    button.addTarget(self, action: "commentButtonDidPress", forControlEvents: .TouchUpInside)

    return button
    }()

  public lazy var seenButton: UIButton = { [unowned self] in
    let button = UIButton()
    button.titleLabel?.font = UIFont.italicSystemFontOfSize(12)
    button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
    button.addTarget(self, action: "seenButtonDidPress", forControlEvents: .TouchUpInside)

    return button
    }()

  public weak var delegate: PostInformationBarViewDelegate?

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [likesButton, commentButton, seenButton].forEach {
      addSubview($0)
      $0.opaque = true
      $0.backgroundColor = UIColor.whiteColor()
      $0.subviews.first?.opaque = true
      $0.subviews.first?.backgroundColor = UIColor.whiteColor()
    }

    backgroundColor = UIColor.whiteColor()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public func configureView(likes: Int, comments: Int, seen: Int) {
    configureLikes(likes)
    configureComments(comments)
    configureSeen(seen)
  }

  public func configureLikes(likes: Int) {
    likesButton.setTitle("\(likes) likes", forState: .Normal)
    likesButton.sizeToFit()
    likesButton.frame.origin = CGPoint(x: Dimensions.offset, y: Dimensions.topOffset)
  }

  public func configureComments(comments: Int) {
    commentButton.setTitle("\(comments) comments", forState: .Normal)
    commentButton.sizeToFit()
    commentButton.frame.origin = CGPoint(x: CGRectGetMaxX(likesButton.frame) + Dimensions.interitemOffset,
      y: Dimensions.topOffset)
  }

  public func configureSeen(seen: Int) {
    seenButton.setTitle("Seen by \(seen)", forState: .Normal)
    seenButton.sizeToFit()
    seenButton.frame.origin = CGPoint(x: UIScreen.mainScreen().bounds.width - seenButton.frame.width - Dimensions.offset,
      y: Dimensions.topOffset)
  }

  // MARK: - Action methods

  public func likesButtonDidPress() {
    delegate?.likesInformationButtonDidPress()
  }

  public func commentButtonDidPress() {
    delegate?.commentInformationButtonDidPress()
  }

  public func seenButtonDidPress() {
    delegate?.seenInformationButtonDidPress()
  }
}
