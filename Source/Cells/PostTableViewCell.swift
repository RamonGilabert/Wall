import UIKit

public class PostTableViewCell: UITableViewCell {

  public static let reusableIdentifier = "PostTableViewCell"

  public lazy var authorView: PostAuthorView = {
    let view = PostAuthorView()
    return view
    }()

  public lazy var postImagesView: PostImagesView = {
    let view = PostImagesView()
    return view
    }()

  public lazy var postTextView: PostTextView = {
    let view = PostTextView()
    return view
    }()

  public lazy var informationView: PostInformationBarView = {
    let view = PostInformationBarView()
    return view
    }()

  public lazy var actionBarView: PostActionBarView = {
    let view = PostActionBarView()
    return view
    }()

  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    [authorView, postImagesView, postTextView, informationView, actionBarView].forEach { addSubview($0) }
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configureCell(post: Post) {
    guard let author = post.author else { return }

    authorView.configureView(author)
    postImagesView.configureView(post.images)
    postTextView.configureView(post.text)
    informationView.configureView(post.likeCount, comments: post.commentCount, seen: post.seenCount)
    actionBarView.configureView(post.liked)
  }
}
