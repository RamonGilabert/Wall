import UIKit

class PostTableViewCell: UITableViewCell {

  static let reusableIdentifier = "PostTableViewCell"

  lazy var authorVIew: PostAuthorView = {
    let view = PostAuthorView()
    return view
    }()

  lazy var postImagesView: PostImagesView = {
    let view = PostImagesView()
    return view
    }()

  lazy var informationView: PostInformationBarView = {
    let view = PostInformationBarView()
    return view
    }()

  lazy var actionBarView: PostActionBarView = {
    let view = PostActionBarView()
    return view
    }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  func configureCell(post: Post) {

  }
}
