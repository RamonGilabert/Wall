import UIKit
import SDWebImage

public class PostAuthorView: UIView {

  public struct Dimensions {
    public static let avatarOffset: CGFloat = 10
    public static let avatarSize: CGFloat = 40
    public static let nameOffset: CGFloat = Dimensions.avatarOffset * 2 + Dimensions.avatarSize
    public static let nameTopOffset: CGFloat = 14
  }

  public lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .ScaleAspectFill
    imageView.clipsToBounds = true
    imageView.opaque = true
    imageView.backgroundColor = UIColor.whiteColor()

    return imageView
    }()

  public lazy var authorName: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFontOfSize(14)

    return label
    }()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [avatarImageView, authorName].forEach {
      addSubview($0)
      $0.opaque = true
      $0.backgroundColor = UIColor.whiteColor()
    }

    backgroundColor = UIColor.whiteColor()
  }

  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)

    avatarImageView.frame = CGRect(x: Dimensions.avatarOffset, y: Dimensions.avatarOffset,
      width: Dimensions.avatarSize, height: Dimensions.avatarSize)
    authorName.frame = CGRect(x: Dimensions.nameOffset, y: Dimensions.nameTopOffset,
      width: UIScreen.mainScreen().bounds.width - 70, height: 20)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public func configureView(author: Author) {
    if let avatarURL = author.avatar {
      avatarImageView.sd_setImageWithURL(avatarURL)
    }

    authorName.text = author.name
  }
}
