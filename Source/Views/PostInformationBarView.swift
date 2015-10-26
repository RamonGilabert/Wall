import UIKit

public class PostInformationBarView: UIView {

  public lazy var likesLabel: UILabel = {
    let label = UILabel()
    return label
    }()

  public lazy var commentsLabel: UILabel = {
    let label = UILabel()
    return label
    }()

  public lazy var seenLabel: UILabel = {
    let label = UILabel()
    return label
    }()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [likesLabel, commentsLabel, seenLabel].forEach { addSubview($0) }
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public func configureView(likes: Int, comments: Int, seen: Int) {

  }

  // MARK: - Setup frames

  public func setupFrames() {

  }
}
