import UIKit

public class PostAuthorView: UIView {

  public lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
    }()

  public lazy var authorName: UILabel = {
    let label = UILabel()
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

  }

  // MARK: - Setup frames

  public func setupFrames() {

  }
}
