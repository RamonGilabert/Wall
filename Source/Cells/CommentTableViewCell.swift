import UIKit

public class CommentTableViewCell: WallTableViewCell {

  public static let reusableIdentifier = "CommentTableViewCell"

  public struct Dimensions {
    public static let sideOffset: CGFloat = 10
    public static let avatarSize: CGFloat = 40
    public static let textOffset: CGFloat = Dimensions.sideOffset * 2 + Dimensions.avatarSize
    public static let nameTopOffset: CGFloat = 12
    public static let dateTopOffset: CGFloat = 30
  }

  public let nodeAttributesURL = "nodeAttributesURL"

  public lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = Dimensions.avatarSize / 2
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

  public lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.lightGrayColor()
    label.font = UIFont.systemFontOfSize(12)

    return label
    }()

  public lazy var postText: UITextView = { [unowned self] in
    let textView = UITextView()
    textView.font = UIFont.systemFontOfSize(14)
    textView.dataDetectorTypes = .Link
    textView.editable = false
    textView.scrollEnabled = false
    textView.delegate = self
    textView.textContainer.lineFragmentPadding = 0
    textView.textContainerInset = UIEdgeInsetsZero
    textView.linkTextAttributes = [
      NSForegroundColorAttributeName: UIColor.redColor(),
      NSUnderlineColorAttributeName: UIColor.redColor(),
      NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]

    return textView
    }()

  public lazy var bottomSeparator: CALayer = {
    let layer = CALayer()
    layer.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1).CGColor
    layer.opaque = true

    return layer
    }()

  // MARK: - Initialization

  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    [avatarImageView, authorName, postText, dateLabel].forEach {
      addSubview($0)
      $0.opaque = true
      $0.backgroundColor = UIColor.whiteColor()
    }

    layer.addSublayer(bottomSeparator)
    opaque = true
    selectionStyle = .None
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)

    guard let post = post, author = post.author else { return }

    avatarImageView.frame = CGRect(x: Dimensions.sideOffset, y: Dimensions.sideOffset,
      width: Dimensions.avatarSize, height: Dimensions.avatarSize)
    if let avatarURL = author.avatar {
      avatarImageView.sd_setImageWithURL(avatarURL)
    }

    authorName.frame = CGRect(x: Dimensions.textOffset, y: Dimensions.nameTopOffset,
      width: UIScreen.mainScreen().bounds.width - 70, height: 20)
    authorName.text = author.name

    postText.text = post.text
    postText.frame.size.width = UIScreen.mainScreen().bounds.width - Dimensions.textOffset - Dimensions.sideOffset
    postText.sizeToFit()
    postText.frame = CGRect(x: Dimensions.textOffset, y: authorName.frame.maxY + 12,
      width: postText.frame.width, height: postText.frame.height)

    dateLabel.frame = CGRect(x: Dimensions.textOffset, y: postText.frame.maxY + 26,
      width: postText.frame.width, height: 17)
    dateLabel.text = post.publishDate

    bottomSeparator.frame = CGRect(x: 0, y: dateLabel.frame.maxY + 26,
      width: UIScreen.mainScreen().bounds.width, height: 20)
  }
}

// MARK: - UITextViewDelegate

extension CommentTableViewCell: UITextViewDelegate {

  public func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
    return true
  }
}
