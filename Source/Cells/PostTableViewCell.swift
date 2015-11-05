import UIKit

public protocol PostTableViewCellDelegate: class {

  func updateCellSize(postID: Int)
}

public protocol PostActionDelegate: class {

  func likeButtonDidPress(postID: Int)
  func commentsButtonDidPress(postID: Int)
}

public protocol PostInformationDelegate: class {

  func likesInformationDidPress(postID: Int)
  func commentsInformationDidPress(postID: Int)
  func seenInformationDidPress(postID: Int)
  func authorDidTap(postID: Int)
}

public class PostTableViewCell: UITableViewCell {

  public static let reusableIdentifier = "PostTableViewCell"

  public lazy var authorView: PostAuthorView = { [unowned self] in
    let view = PostAuthorView()
    view.delegate = self

    return view
    }()

  public lazy var postImagesView: PostImagesView = {
    let view = PostImagesView()
    return view
    }()

  public lazy var postText: UITextView = {
    let textView = UITextView()
    textView.font = UIFont.systemFontOfSize(14)
    textView.dataDetectorTypes = .Link
    textView.editable = false
    textView.scrollEnabled = false
    textView.textContainer.lineFragmentPadding = 0
    textView.textContainerInset = UIEdgeInsetsZero
    textView.linkTextAttributes = [
      NSForegroundColorAttributeName: UIColor.redColor(),
      NSUnderlineColorAttributeName: UIColor.redColor(),
      NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]

    return textView
    }()

  public lazy var informationView: PostInformationBarView = { [unowned self] in
    let view = PostInformationBarView()
    view.delegate = self

    return view
    }()

  public lazy var actionBarView: PostActionBarView = { [unowned self] in
    let view = PostActionBarView()
    view.delegate = self

    return view
    }()

  public lazy var bottomSeparator: CALayer = {
    let layer = CALayer()
    layer.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1).CGColor
    layer.opaque = true

    return layer
    }()

  public weak var delegate: PostTableViewCellDelegate?
  public weak var actionDelegate: PostActionDelegate?
  public weak var informationDelegate: PostInformationDelegate?
  public var post: Post?

  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    [authorView, postImagesView, postText,
      informationView, actionBarView].forEach {
        addSubview($0)
        $0.opaque = true
        $0.backgroundColor = UIColor.whiteColor()
    }

    layer.addSublayer(bottomSeparator)
    opaque = true
    selectionStyle = .None
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func drawRect(rect: CGRect) {
    super.drawRect(rect)

    guard let post = post, author = post.author else { return }

    var imageHeight: CGFloat = 0
    var imageTop: CGFloat = 50
    if !post.images.isEmpty {
      imageHeight = 274
      imageTop = 60
      postImagesView.configureView(post.images)
      postImagesView.alpha = 1
    } else {
      postImagesView.alpha = 0
    }

    var informationHeight: CGFloat = 56
    if post.likeCount == 0 && post.commentCount == 0 {
      informationHeight = 16
    }

    authorView.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 60)
    postImagesView.frame = CGRect(x: 0, y: imageTop, width: UIScreen.mainScreen().bounds.width, height: imageHeight)
    informationView.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: informationHeight)
    actionBarView.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: 44)
    bottomSeparator.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 20)

    authorView.configureView(author, date: post.publishDate)
    informationView.configureView(post.likeCount, comments: post.commentCount, seen: post.seenCount)
    actionBarView.configureView(post.liked)

    postText.text = post.text
    postText.frame.size.width = UIScreen.mainScreen().bounds.width - 40
    postText.sizeToFit()
    postText.frame = CGRect(x: 20, y: CGRectGetMaxY(postImagesView.frame) + 12,
      width: postText.frame.width, height: postText.frame.height)

    informationView.frame.origin = CGPoint(x: 0, y: CGRectGetMaxY(postText.frame))
    actionBarView.frame.origin = CGPoint(x: 0, y: CGRectGetMaxY(informationView.frame))
    bottomSeparator.frame.origin.y = CGRectGetMaxY(actionBarView.frame)
  }

  public func configureCell(post: Post) {
    self.post = post
  }
}

extension PostTableViewCell: UITextViewDelegate {

  public func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
    return true
  }
}

extension PostTableViewCell: PostInformationBarViewDelegate {

  public func likesInformationButtonDidPress() {
    guard let post = post else { return }
    informationDelegate?.likesInformationDidPress(post.id)
  }

  public func commentInformationButtonDidPress() {
    guard let post = post else { return }
    informationDelegate?.commentsInformationDidPress(post.id)
  }

  public func seenInformationButtonDidPress() {
    guard let post = post else { return }
    informationDelegate?.seenInformationDidPress(post.id)
  }
}

extension PostTableViewCell: PostActionBarViewDelegate {

  public func likeButtonDidPress(liked: Bool) {
    guard let post = post else { return }

    post.liked = liked
    post.likeCount += liked ? 1 : -1

    informationView.configureLikes(post.likeCount)
    informationView.configureComments(post.commentCount)
    delegate?.updateCellSize(post.id)
    actionDelegate?.likeButtonDidPress(post.id)
  }

  public func commentButtonDidPress() {
    guard let post = post else { return }
    actionDelegate?.commentsButtonDidPress(post.id)
  }
}

extension PostTableViewCell: PostAuthorViewDelegate {

  public func authorDidTap() {
    guard let post = post else { return }
    informationDelegate?.authorDidTap(post.id)
  }
}
