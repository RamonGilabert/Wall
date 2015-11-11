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
    public static let nameOffset: CGFloat = Dimensions.avatarOffset * 2 + Dimensions.avatarSize
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

  // MARK: - Initialization

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [dateLabel, authorLabel, avatarImageView].forEach {
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

  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    let totalWidth = UIScreen.mainScreen().bounds.width

    avatarImageView.frame = CGRect(x: Dimensions.avatarOffset, y: Dimensions.avatarOffset,
      width: Dimensions.avatarSize, height: Dimensions.avatarSize)
    authorLabel.frame = CGRect(x: Dimensions.nameOffset, y: Dimensions.nameTopOffset,
      width: totalWidth - 70, height: 20)
    groupLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    dateLabel.frame = CGRect(x: Dimensions.nameOffset, y: Dimensions.dateTopOffset,
      width: totalWidth - 70, height: 17)
  }

  public func configureView(author: Author, date: String, group: String = "") {
    if let avatarURL = author.avatar {
      avatarImageView.sd_setImageWithURL(avatarURL)
    }

    authorLabel.text = author.name
    dateLabel.text = date
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
