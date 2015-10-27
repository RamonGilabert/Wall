import UIKit

public class PostActionBarView: UIView {

  public lazy var topSeparator: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.grayColor()
    view.frame = CGRect(x: 10, y: 0, width: UIScreen.mainScreen().bounds.width - 20, height: 0.5)

    return view
    }()

  public lazy var likeButton: UIButton = { [unowned self] in
    let button = UIButton()
    button.setTitle("Like", forState: .Normal)
    button.titleLabel?.font = UIFont.boldSystemFontOfSize(14)
    button.frame = CGRect(x: 10, y: 0.5, width: UIScreen.mainScreen().bounds.width / 2 - 20, height: 43)
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

    [topSeparator, likeButton, commentButton].forEach { addSubview($0) }

    backgroundColor = UIColor.whiteColor()
    
    layer.shadowColor = UIColor.blackColor().CGColor
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowOpacity = 0.1
    layer.shadowRadius = 1
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
