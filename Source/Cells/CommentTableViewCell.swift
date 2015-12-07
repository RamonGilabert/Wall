import UIKit

public protocol CommentTableViewCellDelegate: class {

  func commentAuthorDidTap(commentID: Int)
}

public class CommentTableViewCell: WallTableViewCell {

  public override class func height(post: Post) -> CGFloat {
    let postText = post.text as NSString
    let textFrame = postText.boundingRectWithSize(CGSize(
      width: UIScreen.mainScreen().bounds.width - Dimensions.textOffset - Dimensions.sideOffset,
      height: CGFloat.max), options: .UsesLineFragmentOrigin,
      attributes: [ NSFontAttributeName : FontList.Comment.text ], context: nil)

    return ceil(70.5 + textFrame.height)
  }

  public static let reusableIdentifier = "CommentTableViewCell"

  public struct Dimensions {
    public static let sideOffset: CGFloat = 10
    public static let avatarSize: CGFloat = 40
    public static let textOffset: CGFloat = Dimensions.sideOffset * 2 + Dimensions.avatarSize
    public static let nameTopOffset: CGFloat = 12
    public static let dateTopOffset: CGFloat = 30
  }

  public lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.cornerRadius = Dimensions.avatarSize / 2
    imageView.contentMode = .ScaleAspectFill
    imageView.clipsToBounds = true
    imageView.opaque = true
    imageView.backgroundColor = UIColor.whiteColor()
    imageView.userInteractionEnabled = true

    return imageView
    }()

  public lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.font = FontList.Comment.author
    label.userInteractionEnabled = true

    return label
    }()

  public lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.textColor = ColorList.Comment.date
    label.font = FontList.Comment.date

    return label
    }()

  public lazy var textView: UITextView = { [unowned self] in
    let textView = UITextView()
    textView.font = FontList.Comment.text
    textView.dataDetectorTypes = .Link
    textView.editable = false
    textView.scrollEnabled = false
    textView.delegate = self
    textView.textContainer.lineFragmentPadding = 0
    textView.textContainerInset = UIEdgeInsetsZero
    textView.linkTextAttributes = [
      NSForegroundColorAttributeName: ColorList.Basis.highlightedColor,
      NSUnderlineColorAttributeName: ColorList.Basis.highlightedColor,
      NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
    textView.subviews.first?.backgroundColor = ColorList.Comment.background

    return textView
    }()

  public lazy var bottomSeparator: UIView = {
    let view = UIView()
    return view
    }()

  public lazy var imageTapGestureRecognizer: UITapGestureRecognizer = { [unowned self] in
    let gesture = UITapGestureRecognizer()
    gesture.addTarget(self, action: "handleAuthorGestureRecognizer")

    return gesture
    }()

  public lazy var authorTapGestureRecognizer: UITapGestureRecognizer = { [unowned self] in
    let gesture = UITapGestureRecognizer()
    gesture.addTarget(self, action: "handleAuthorGestureRecognizer")

    return gesture
    }()

  public weak var commentDelegate: CommentTableViewCellDelegate?

  // MARK: - Initialization

  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    [avatarImageView, authorLabel, textView, dateLabel, bottomSeparator].forEach {
      addSubview($0)
      $0.opaque = true
      $0.backgroundColor = ColorList.Comment.background
    }

    bottomSeparator.backgroundColor = ColorList.Comment.separator
    backgroundColor = ColorList.Comment.background

    avatarImageView.addGestureRecognizer(imageTapGestureRecognizer)
    authorLabel.addGestureRecognizer(authorTapGestureRecognizer)

    opaque = true
    selectionStyle = .None
  }

  public override func configureCell(post: Post) {
    guard let author = post.author else { return }
    let totalWidth = UIScreen.mainScreen().bounds.width

    avatarImageView.frame = CGRectIntegral(CGRect(x: Dimensions.sideOffset, y: Dimensions.sideOffset,
      width: Dimensions.avatarSize, height: Dimensions.avatarSize))
    if let avatarURL = author.avatar {
      avatarImageView.setImage(avatarURL,
        placeholder: UIImage(named: ImageList.Basis.placeholder))
    }

    authorLabel.frame = CGRectIntegral(CGRect(x: Dimensions.textOffset, y: Dimensions.nameTopOffset,
      width: totalWidth - 70, height: 20))
    authorLabel.text = author.name

    textView.text = post.text
    textView.frame.size.width = ceil(totalWidth - Dimensions.textOffset - Dimensions.sideOffset)
    textView.sizeToFit()
    textView.frame = CGRectIntegral(CGRect(x: Dimensions.textOffset, y: 36,
      width: textView.frame.width, height: textView.frame.height))

    updateDate(post)

    bottomSeparator.frame = CGRectIntegral(CGRect(x: 8, y: dateLabel.frame.maxY + 8, width: totalWidth - 16, height: 0.5))
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Actions

  public func handleAuthorGestureRecognizer() {
    guard let post = post else { return }
    commentDelegate?.commentAuthorDidTap(post.id)
  }

  // MARK: - Setup

  public func updateDate(post: Post) {
    dateLabel.frame = CGRectIntegral(CGRect(x: Dimensions.textOffset, y: textView.frame.maxY + 9,
      width: UIScreen.mainScreen().bounds.width, height: 17))
    dateLabel.text = post.publishDate

    if post.publishDate == "1 Jan 01:00" || post.publishDate == "1 jan. 01:00" {
      dateLabel.text = NSLocalizedString("Publishing", comment: "")
    }
  }
}

// MARK: - UITextViewDelegate

extension CommentTableViewCell: UITextViewDelegate {

  public func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
    return true
  }
}
