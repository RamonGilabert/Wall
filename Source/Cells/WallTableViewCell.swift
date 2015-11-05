import UIKit

public protocol WallTableViewCellDelegate: class {

  func updateCellSize(postID: Int)
}

public class WallTableViewCell: UITableViewCell {

  public var post: Post?
  public weak var delegate: WallTableViewCellDelegate?

  public func configureCell(post: Post) {
    self.post = post
  }
}
