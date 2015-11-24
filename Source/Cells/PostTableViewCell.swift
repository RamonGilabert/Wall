import UIKit

public protocol PostActionDelegate: class {

  func likeButtonDidPress(postID: Int)
  func commentsButtonDidPress(postID: Int)
}

public protocol PostInformationDelegate: class {

  func likesInformationDidPress(postID: Int)
  func commentsInformationDidPress(postID: Int)
  func seenInformationDidPress(postID: Int)
  func authorDidTap(postID: Int)
  func mediaDidTap(postID: Int, kind: Media.Kind, index: Int)
  func groupDidTap(postID: Int)
  func reportButtonDidPress(postID: Int)
}

public class PostTableViewCell: WallTableViewCell {

  public static let reusableIdentifier = "PostTableViewCell"

  public override class func height(post: Post) -> CGFloat {
    let postText = post.text as NSString
    let textFrame = postText.boundingRectWithSize(CGSize(width: UIScreen.mainScreen().bounds.width - 40,
      height: CGFloat.max), options: .UsesLineFragmentOrigin,
      attributes: [ NSFontAttributeName : FontList.Post.text ], context: nil)

    var imageHeight: CGFloat = ceil((UIScreen.mainScreen().bounds.width - 20) / 1.295)
    var imageTop: CGFloat = 60
    if post.media.isEmpty {
      imageHeight = 0
      imageTop = 50
    }

    var textOffset: CGFloat = 12
    if post.text == "" {
      textOffset = 0
    }

    var informationHeight: CGFloat = 44
    if (post.likeCount == 0 && post.commentCount == 0 && post.text == "")
      || (post.likeCount == 0 && post.commentCount == 0) {
        informationHeight = 16
    }

    return ceil(imageHeight + imageTop + informationHeight + 44 + 20 + textOffset + textFrame.height)
  }

  public lazy var authorView: PostAuthorView = { [unowned self] in
    let view = PostAuthorView()
    view.delegate = self

    return view
    }()

  public lazy var postMediaView: PostMediaView = { [unowned self] in
    let view = PostMediaView()
    view.delegate = self

    return view
    }()

  public lazy var textView: UITextView = { [unowned self] in
    let textView = UITextView()
    textView.font = FontList.Post.text
    textView.dataDetectorTypes = .Link
    textView.editable = false
    textView.scrollEnabled = false
    textView.delegate = self
    textView.textContainer.lineFragmentPadding = 0
    textView.textContainerInset = UIEdgeInsetsZero
    textView.linkTextAttributes = [
      NSForegroundColorAttributeName: ColorList.Basis.highlightedColor,
      NSUnderlineColorAttributeName: ColorList.Basis.highlightedColor,
      NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
    textView.subviews.first?.backgroundColor = UIColor.whiteColor()

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

  public lazy var bottomSeparator: UIView = {
    let view = UIView()
    return view
    }()

  public weak var actionDelegate: PostActionDelegate?
  public weak var informationDelegate: PostInformationDelegate?
  public var detail = false

  // MARK: - Initialization

  public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    [authorView, postMediaView, textView,
      informationView, actionBarView, bottomSeparator].forEach {
        addSubview($0)
        $0.opaque = true
        $0.backgroundColor = UIColor.whiteColor()
        $0.layer.drawsAsynchronously = true
    }

    bottomSeparator.backgroundColor = ColorList.Basis.tableViewBackground
    opaque = true
    selectionStyle = .None
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Setup

  public override func configureCell(post: Post) {
    super.configureCell(post)

    guard let author = post.author else { return }

    var imageHeight: CGFloat = 0
    var imageTop: CGFloat = 50
    if !post.media.isEmpty {
      imageHeight = ceil((UIScreen.mainScreen().bounds.width - 20) / 1.295)
      imageTop = 60
      postMediaView.configureView(post.media)
      postMediaView.alpha = 1
    } else {
      postMediaView.alpha = 0
    }

    var informationHeight: CGFloat = 44
    if (post.likeCount == 0 && post.commentCount == 0 && post.text == "")
      || (post.likeCount == 0 && post.commentCount == 0) {
        informationHeight = 16
    }

    if detail && post.likeCount == 0 {
      informationHeight = 16
    }

    var textOffset: CGFloat = 12
    if post.text == "" {
      textOffset = 0
    }

    authorView.frame = CGRectIntegral(CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 60))
    postMediaView.frame = CGRectIntegral(CGRect(x: 0, y: imageTop, width: UIScreen.mainScreen().bounds.width, height: imageHeight))
    informationView.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: ceil(informationHeight))
    actionBarView.frame.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: 44)
    bottomSeparator.frame = CGRectIntegral(CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 20))

    authorView.configureView(author, date: post.publishDate, group: post.group)
    informationView.configureView(post.likeCount, comments: post.commentCount, seen: post.seenCount)
    actionBarView.configureView(post.liked)

    textView.text = post.text
    textView.frame.size.width = UIScreen.mainScreen().bounds.width - 40
    textView.sizeToFit()
    textView.frame = CGRectIntegral(CGRect(x: 20, y: CGRectGetMaxY(postMediaView.frame) + textOffset,
      width: textView.frame.width, height: textView.frame.height))

    informationView.frame.origin = CGPoint(x: 0, y: ceil(CGRectGetMaxY(textView.frame)))
    actionBarView.frame.origin = CGPoint(x: 0, y: ceil(CGRectGetMaxY(informationView.frame)))
    bottomSeparator.frame.origin.y = ceil(CGRectGetMaxY(actionBarView.frame))
  }
}

// MARK: - UITextViewDelegate

extension PostTableViewCell: UITextViewDelegate {

  public func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
    return true
  }
}

// MARK: - PostInformationBarViewDelegate

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

// MARK: - PostActionBarViewDelegate

extension PostTableViewCell: PostActionBarViewDelegate {

  public func likeButtonDidPress(liked: Bool) {
    guard let post = post else { return }

    post.liked = liked
    post.likeCount += liked ? 1 : -1

    informationView.configureLikes(post.likeCount)
    informationView.configureComments(post.commentCount)
    delegate?.updateCellSize(post.id, liked: liked)
    actionDelegate?.likeButtonDidPress(post.id)
  }

  public func commentButtonDidPress() {
    guard let post = post else { return }
    actionDelegate?.commentsButtonDidPress(post.id)
  }
}

// MARK: - PostAuthorViewDelegate

extension PostTableViewCell: PostAuthorViewDelegate {

  public func authorDidTap() {
    guard let post = post else { return }
    informationDelegate?.authorDidTap(post.id)
  }

  public func groupDidTap() {
    guard let post = post else { return }
    informationDelegate?.groupDidTap(post.id)
  }

  public func reportButtonDidPress() {
    guard let post = post else { return }
    informationDelegate?.reportButtonDidPress(post.id)
  }
}

extension PostTableViewCell: PostMediaViewDelegate {

  public func mediaDidTap(index: Int) {
    guard let post = post, firstMedia = post.media.first else { return }
    informationDelegate?.mediaDidTap(post.id, kind: firstMedia.kind, index: index)
  }
}
