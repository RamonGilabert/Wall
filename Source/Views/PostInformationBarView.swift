import UIKit

public class PostInformationBarView: UIView {

  public struct Dimensions {
    public static let offset: CGFloat = 20
    public static let topOffset: CGFloat = 18
    public static let interitemOffset: CGFloat = 10
  }

  public lazy var likesLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFontOfSize(12)
    label.textColor = UIColor.lightGrayColor()

    return label
    }()

  public lazy var commentsLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFontOfSize(12)
    label.textColor = UIColor.lightGrayColor()

    return label
    }()

  public lazy var seenLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.italicSystemFontOfSize(12)
    label.textColor = UIColor.lightGrayColor()

    return label
    }()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [likesLabel, commentsLabel, seenLabel].forEach {
      addSubview($0)
      $0.opaque = true
      $0.backgroundColor = UIColor.whiteColor()
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
    likesLabel.text = "\(likes) likes"
    likesLabel.sizeToFit()
    likesLabel.frame.origin = CGPoint(x: Dimensions.offset, y: Dimensions.topOffset)
  }

  public func configureComments(comments: Int) {
    commentsLabel.text = "\(comments) comments"
    commentsLabel.sizeToFit()
    commentsLabel.frame.origin = CGPoint(x: CGRectGetMaxX(likesLabel.frame) + Dimensions.interitemOffset,
      y: Dimensions.topOffset)
  }

  public func configureSeen(seen: Int) {
    seenLabel.text = "Seen by \(seen)"
    seenLabel.sizeToFit()
    seenLabel.frame.origin = CGPoint(x: UIScreen.mainScreen().bounds.width - seenLabel.frame.width - Dimensions.offset,
      y: Dimensions.topOffset)
  }
}
