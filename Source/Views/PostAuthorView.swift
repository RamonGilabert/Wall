import UIKit
import Kingfisher

public class PostAuthorView: UIView {

  public lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
    imageView.contentMode = .ScaleAspectFill
    imageView.clipsToBounds = true

    return imageView
    }()

  public lazy var authorName: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFontOfSize(14)
    label.frame = CGRect(x: 60, y: 14,
      width: UIScreen.mainScreen().bounds.width - 70, height: 20)

    return label
    }()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [avatarImageView, authorName].forEach { addSubview($0) }
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public func configureView(author: Author) {
    if let avatarURL = author.avatar {
      avatarImageView.kf_setImageWithURL(avatarURL)
    }

    authorName.text = author.name
  }
}
