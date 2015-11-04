import UIKit

public class PostInformationBarView: UIView {

  public struct Dimensions {
    public static let offset: CGFloat = 24
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

  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)

    [likesLabel, commentsLabel, seenLabel].forEach { $0.sizeToFit() }

    likesLabel.frame.origin = CGPoint(x: 24, y: 18)
    commentsLabel.frame.origin = CGPoint(x: CGRectGetMaxX(likesLabel.frame) + 10, y: 18)
    seenLabel.frame.origin = CGPoint(x: UIScreen.mainScreen().bounds.width - seenLabel.frame.width - 24, y: 18)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public func configureView(likes: Int, comments: Int, seen: Int) {
    likesLabel.text = "\(likes) likes"
    commentsLabel.text = "\(comments) comments"
    seenLabel.text = "Seen by \(seen)"
  }

  // MARK: - Setup frames

  public func setupFrames() {

  }
}
