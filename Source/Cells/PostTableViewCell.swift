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
    view.frame = CGRect(x: 0, y: 60, width: UIScreen.mainScreen().bounds.width, height: 274)

    return view
    }()

  public lazy var postText: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFontOfSize(14)
    label.numberOfLines = 0

    return label
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

  public lazy var bottomSeparator: UIView = {
    let view = UIView()
    view.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 20)
    view.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1)

    return view
    }()

  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    [bottomSeparator, authorView, postImagesView, postText,
      informationView, actionBarView].forEach {
        addSubview($0)
        $0.layer.drawsAsynchronously = true
        $0.opaque = true
    }

    layer.drawsAsynchronously = true
    opaque = true
    selectionStyle = .None
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func configureCell(post: Post) {
    guard let author = post.author else { return }

    authorView.configureView(author)
    postImagesView.configureView(post.images)
    informationView.configureView(post.likeCount, comments: post.commentCount, seen: post.seenCount)
    actionBarView.configureView(post.liked)

    postText.text = post.text
    postText.frame.size.width = UIScreen.mainScreen().bounds.width - 20
    postText.sizeToFit()
    postText.frame = CGRect(x: 10, y: CGRectGetMaxY(postImagesView.frame) + 12,
      width: postText.frame.width, height: postText.frame.height)

    informationView.frame.origin = CGPoint(x: 0, y: CGRectGetMaxY(postText.frame))
    actionBarView.frame.origin = CGPoint(x: 0, y: CGRectGetMaxY(informationView.frame))
    bottomSeparator.frame.origin.y = CGRectGetMaxY(actionBarView.frame)
  }
}
