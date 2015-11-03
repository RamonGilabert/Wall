import UIKit

public class PostActionBarView: UIView {

  public lazy var topSeparator: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.grayColor()

    return view
    }()

  public lazy var likeButton: UIButton = { [unowned self] in
    let button = UIButton()
    button.setTitle("Like", forState: .Normal)
    button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
    button.addTarget(self, action: "likeButtonDidPress", forControlEvents: .TouchUpInside)

    return button
    }()

  public lazy var commentButton: UIButton = {
    let button = UIButton()
    button.setTitle("Comment", forState: .Normal)
    button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
    button.setTitleColor(UIColor.grayColor(), forState: .Normal)
    button.frame = CGRect(x: UIScreen.mainScreen().bounds.width / 2, y: 0.5,
      width: UIScreen.mainScreen().bounds.width / 2 - 20, height: 43)

    return button
    }()

  public override init(frame: CGRect) {
    super.init(frame: frame)

    [topSeparator, likeButton, commentButton].forEach {
      addSubview($0)
      $0.opaque = true
    }

    backgroundColor = UIColor.whiteColor()
  }

  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)

    let totalWidth = UIScreen.mainScreen().bounds.width

    topSeparator.frame = CGRect(x: 10, y: 0, width: totalWidth - 20, height: 0.5)
    likeButton.frame = CGRect(x: 10, y: 0.5, width: totalWidth / 2 - 20, height: 43)
    commentButton.frame = CGRect(x: totalWidth / 2, y: 0.5, width: totalWidth / 2 - 20, height: 43)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public func configureView(liked: Bool) {
    let color = liked ? UIColor.redColor() : UIColor.grayColor()
    likeButton.setTitleColor(color, forState: .Normal)
  }

  // MARK: - Action methods

  public func likeButtonDidPress() {
    let color = likeButton.titleColorForState(.Normal) == UIColor.redColor()
      ? UIColor.grayColor() : UIColor.redColor()

    if color == UIColor.redColor() {
      UIView.animateWithDuration(0.1, animations: {
        self.likeButton.transform = CGAffineTransformMakeScale(1.35, 1.35)
        }, completion: { _ in
          UIView.animateWithDuration(0.1, animations: {
            self.likeButton.transform = CGAffineTransformIdentity
          })
      })
    }

    likeButton.setTitleColor(color, forState: .Normal)
  }
}
