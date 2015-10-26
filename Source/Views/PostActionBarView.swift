import UIKit

public class PostActionBarView: UIView {

  public lazy var topSeparator: UIView = {
    let view = UIView()
    return view
    }()

  public lazy var likeButton: UIButton = {
    let button = UIButton()
    return button
    }()

  public lazy var commentButton: UIButton = {
    let button = UIButton()
    return button
    }()

  public lazy var bottomSeparator: UIView = {
    let view = UIView()
    return view
    }()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [topSeparator, likeButton, commentButton, bottomSeparator].forEach { addSubview($0) }
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public func configureView(liked: Bool) {
    
  }

  // MARK: - Setup frames

  public func setupFrames() {

  }
}
