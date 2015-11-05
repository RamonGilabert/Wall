import UIKit

public protocol WallTableViewCellDelegate: class {

  func updateCellSize(postID: Int)
}

public class WallTableViewCell: UITableViewCell {

  public class func height(post: Post) -> CGFloat {
    return 44
  }

  public var post: Post?
  public weak var delegate: WallTableViewCellDelegate?

  public func configureCell(post: Post) {
    self.post = post
  }
}
