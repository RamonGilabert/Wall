import UIKit
import Wall

class PostDetailTableViewCell: PostTableViewCell {

  static let reusableCellIdentifier = "PostDetailTableViewCell"

  override class func height(post: Post) -> CGFloat {
    return super.height(post) - 20
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    bottomSeparator.opacity = 0
    informationView.commentButton.alpha = 0
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
