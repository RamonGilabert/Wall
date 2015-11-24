import UIKit
import SDWebImage

public protocol PostAuthorViewDelegate: class {

  func authorDidTap()
  func groupDidTap()
  func reportButtonDidPress()
}

public class PostAuthorView: UIView {

  public struct Dimensions {
    public static let avatarOffset: CGFloat = 10
    public static let avatarSize: CGFloat = 40
    public static let nameOffset: CGFloat = ceil(Dimensions.avatarOffset * 2 + Dimensions.avatarSize)
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

    return imageView
    }()

  public lazy var authorLabel: UILabel = {
    let label = UILabel()
    label.font = FontList.Post.author

    return label
    }()

  public lazy var disclosureImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: ImageList.Basis.disclosure)

    return imageView
    }()

  public lazy var groupLabel: UILabel = {
    let label = UILabel()
    label.font = FontList.Post.author

    return label
    }()

  public lazy var reportButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: ImageList.Basis.reportButton), forState: .Normal)
    button.addTarget(self, action: "reportButtonDidPress", forControlEvents: .TouchUpInside)

    return button
    }()

  public lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.textColor = ColorList.Post.date
    label.font = FontList.Post.date

    return label
    }()

  public lazy var tapAuthorGestureRecognizer: UITapGestureRecognizer = { [unowned self] in
    let gesture = UITapGestureRecognizer()
    gesture.addTarget(self, action: "handleTapGestureRecognizer")

    return gesture
    }()

  public lazy var tapLabelGestureRecognizer: UITapGestureRecognizer = { [unowned self] in
    let gesture = UITapGestureRecognizer()
    gesture.addTarget(self, action: "handleTapGestureRecognizer")

    return gesture
    }()

  public lazy var tapGroupGestureRecognizer: UITapGestureRecognizer = { [unowned self] in
    let gesture = UITapGestureRecognizer()
    gesture.addTarget(self, action: "handleGroupGestureRecognizer")

    return gesture
    }()

  public weak var delegate: PostAuthorViewDelegate?
  public var shouldDisplayGroup = false

  // MARK: - Initialization

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [dateLabel, authorLabel, avatarImageView, disclosureImageView, groupLabel, reportButton].forEach {
      addSubview($0)
      $0.opaque = true
      $0.backgroundColor = UIColor.whiteColor()
      $0.userInteractionEnabled = true
      $0.layer.drawsAsynchronously = true
    }

    avatarImageView.addGestureRecognizer(tapAuthorGestureRecognizer)
    authorLabel.addGestureRecognizer(tapLabelGestureRecognizer)
    groupLabel.addGestureRecognizer(tapGroupGestureRecognizer)
    backgroundColor = UIColor.whiteColor()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public func configureView(author: Author, date: String, group: String = "") {
    let totalWidth = UIScreen.mainScreen().bounds.width

    if let avatarURL = author.avatar {
      avatarImageView.sd_setImageWithURL(avatarURL,
        placeholderImage: UIImage(named: ImageList.Basis.placeholder))
    }

    if group == "" || !shouldDisplayGroup {
      disclosureImageView.alpha = 0
      groupLabel.alpha = 0
      groupLabel.text = ""
    } else {
      disclosureImageView.alpha = 1
      groupLabel.alpha = 1
      groupLabel.text = group
    }

    authorLabel.text = author.name
    dateLabel.text = date

    [authorLabel, groupLabel].forEach { $0.sizeToFit() }

    avatarImageView.frame = CGRectIntegral(CGRect(x: Dimensions.avatarOffset, y: Dimensions.avatarOffset,
      width: Dimensions.avatarSize, height: Dimensions.avatarSize))
    authorLabel.frame.origin = CGPoint(x: ceil(Dimensions.nameOffset), y: ceil(Dimensions.nameTopOffset))
    disclosureImageView.frame = CGRect(x: ceil(CGRectGetMaxX(authorLabel.frame) + 5), y: 20, width: 3, height: ceil(5.88))

    if CGRectGetMaxX(disclosureImageView.frame) + 41 + groupLabel.frame.width < totalWidth || !shouldDisplayGroup {
      groupLabel.frame.origin = CGPoint(x: ceil(CGRectGetMaxX(disclosureImageView.frame) + 5),
        y: Dimensions.nameTopOffset)
      dateLabel.frame = CGRect(x: Dimensions.nameOffset, y: Dimensions.dateTopOffset,
        width: ceil(totalWidth - 70), height: 17)
    } else {
      groupLabel.frame.origin = CGPoint(x: Dimensions.nameOffset, y: Dimensions.dateTopOffset)
      dateLabel.frame = CGRectIntegral(CGRect(x: ceil(CGRectGetMaxX(groupLabel.frame) + 10), y: Dimensions.dateTopOffset,
        width: ceil(totalWidth - 100), height: 17))
    }

    reportButton.frame = CGRectIntegral(CGRect(x: totalWidth - 32, y: 10, width: 24, height: 24))
  }

  public func updateDate(date: String) {
    dateLabel.text = date
  }

  // MARK: - Actions

  public func handleTapGestureRecognizer() {
    delegate?.authorDidTap()
  }

  public func handleGroupGestureRecognizer() {
    delegate?.groupDidTap()
  }
  
  public func reportButtonDidPress() {
    delegate?.reportButtonDidPress()
  }
}
