import UIKit

public class PostInformationBarView: UIView {

  public struct Dimensions {
    public static let offset: CGFloat = 20
    public static let topOffset: CGFloat = 18
    public static let interitemOffset: CGFloat = 10
  }

  public lazy var likeButton: UIButton = {
    let button = UIButton()
    button.titleLabel?.font = UIFont.systemFontOfSize(12)
    button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)

    return button
    }()

  public lazy var commentButton: UIButton = {
    let button = UIButton()
    button.titleLabel?.font = UIFont.systemFontOfSize(12)
    button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)

    return button
    }()

  public lazy var seenButton: UIButton = {
    let button = UIButton()
    button.titleLabel?.font = UIFont.italicSystemFontOfSize(12)
    button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)

    return button
    }()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [likeButton, commentButton, seenButton].forEach {
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
    likeButton.setTitle("\(likes) likes", forState: .Normal)
    likeButton.sizeToFit()
    likeButton.frame.origin = CGPoint(x: Dimensions.offset, y: Dimensions.topOffset)
  }

  public func configureComments(comments: Int) {
    commentButton.setTitle("\(comments) comments", forState: .Normal)
    commentButton.sizeToFit()
    commentButton.frame.origin = CGPoint(x: CGRectGetMaxX(likeButton.frame) + Dimensions.interitemOffset,
      y: Dimensions.topOffset)
  }

  public func configureSeen(seen: Int) {
    seenButton.setTitle("Seen by \(seen)", forState: .Normal)
    seenButton.sizeToFit()
    seenButton.frame.origin = CGPoint(x: UIScreen.mainScreen().bounds.width - seenButton.frame.width - Dimensions.offset,
      y: Dimensions.topOffset)
  }
}
