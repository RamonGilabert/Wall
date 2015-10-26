import UIKit

public class PostTextView: UIView {

  public lazy var text: UILabel = {
    let label = UILabel()
    return label
    }()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(text)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public func configureView(text: String) {

  }

  // MARK: - Setup frames

  public func setupFrames() {
    
  }
}
