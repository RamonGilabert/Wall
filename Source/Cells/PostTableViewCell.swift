import UIKit

public class PostTableViewCell: UITableViewCell {

  public static let reusableIdentifier = "PostTableViewCell"

  public lazy var authorView: PostAuthorView = {
    let view = PostAuthorView()
    view.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 60)

    return view
    }()

  public lazy var postImagesView: PostImagesView = {
    let view = PostImagesView()
    view.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 274)

    return view
    }()

  public lazy var postTextView: PostTextView = {
    let view = PostTextView()
    view.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: 0)

    return view
    }()

  public lazy var informationView: PostInformationBarView = {
    let view = PostInformationBarView()
    view.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: 56)

    return view
    }()

  public lazy var actionBarView: PostActionBarView = {
    let view = PostActionBarView()
    view.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: 44)

    return view
    }()

  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    [authorView, postImagesView, postTextView, informationView, actionBarView].forEach { addSubview($0) }

    selectionStyle = .None
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

    postTextView.text.sizeToFit()

    postTextView.frame.origin = CGPoint(x: 0, y: CGRectGetMaxY(postImagesView.frame) + 60)
    informationView.frame.origin = CGPoint(x: 0, y: CGRectGetMaxY(postTextView.frame))
    actionBarView.frame.origin = CGPoint(x: 0, y: CGRectGetMaxY(informationView.frame))
  }
}
