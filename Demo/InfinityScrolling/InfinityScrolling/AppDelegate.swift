import UIKit
import Wall
import Fakery

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var navigationController: UINavigationController = { [unowned self] in
    let controller = UINavigationController(rootViewController: self.wallController)
    return controller
    }()

  lazy var wallController: WallController = { [unowned self] in
    let controller = WallController()
    controller.initializePosts(self.generatePosts(0, to: 10))
    controller.title = "Infinity Scrolling".uppercaseString
    controller.delegate = self
    controller.actionDelegate = self
    controller.informationDelegate = self

    return controller
    }()

  lazy var commentController: WallController = { [unowned self] in
    let controller = WallController()
    controller.verticalOffset = 0
    let post = self.generatePosts(0, to: 1, reusableIdentifier: PostDetailTableViewCell.reusableCellIdentifier).first!
    let posts = [post] + self.generatePosts(1, to: 6, reusableIdentifier: CommentTableViewCell.reusableIdentifier)

    controller.initializePosts(posts)
    controller.loadingIndicator.alpha = 0
    controller.title = "Post detail".uppercaseString
    controller.registerCell(CommentTableViewCell.self, reusableIdentifier: CommentTableViewCell.reusableIdentifier)
    controller.registerCell(PostDetailTableViewCell.self, reusableIdentifier: PostDetailTableViewCell.reusableCellIdentifier)
    controller.delegate = self
    controller.actionDelegate = self
    controller.informationDelegate = self
    controller.commentInformationDelegate = self

    return controller
    }()

  let faker = Faker()
  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()

    ImageList.Basis.reportButton = "reportButton"

    return true
  }

  func generatePosts(from: Int, to: Int, reusableIdentifier: String = PostTableViewCell.reusableIdentifier) -> [PostConvertible] {
    var posts = [PostConvertible]()

    for i in from...to {
      autoreleasepool({
        var author = Author(name: "")

        if let imageURL = NSURL(string: "http://lorempixel.com/75/75?type=avatar&id=\(i)") {
          author = Author(name: faker.name.name(),
            avatar: imageURL)
        }

        var media = [Media]()
        var mediaCount = 0
        var likes = 0
        var commentCount = 0
        var seen = 0
        var liked = true

        if i % 4 == 0 {
          mediaCount = 4
          commentCount = 3
          likes = 3
          seen = 4
          liked = false
        } else if i % 3 == 0 {
          mediaCount = 2
          commentCount = 1
          likes = 1
          seen = 2
          liked = true
        } else if i % 2 == 0 {
          mediaCount = 1
          commentCount = 4
          likes = 4
          seen = 6
          liked = false
        }

        for x in 0..<mediaCount {
          if let imageURL = NSURL(string: "http://lorempixel.com/250/250/?type=attachment&id=\(i)\(x)") {
            media.append(Media(kind: .Image, source: imageURL))
          }
        }

        let sencenceCount = Int(arc4random_uniform(8) + 1)
        let post = Post(
          id: i,
          text: faker.lorem.sentences(amount: sencenceCount) + " " + faker.internet.url(),
          publishDate: "3 hours ago",
          author: author,
          media: media
        )

        post.reusableIdentifier = reusableIdentifier
        post.likeCount = likes
        post.seenCount = seen
        post.commentCount = commentCount
        post.liked = liked
        posts.append(post)
      })
    }

    return posts
  }
}

extension AppDelegate: WallControllerDelegate {

  func shouldFetchMoreInformation() {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [unowned self] in
      let posts = self.generatePosts(0, to: 10)
      dispatch_async(dispatch_get_main_queue()) {
        self.wallController.appendPosts(posts)
      }
    }
  }

  func shouldRefreshPosts(refreshControl: UIRefreshControl) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      refreshControl.endRefreshing()
    }
  }

  func didTapCell(id: Int, index: Int) {
    print("Cell selected")
    if navigationController.visibleViewController != commentController {
      commentController.cachedHeights.removeAll()
      navigationController.pushViewController(commentController, animated: true)
    }
  }

  func willDisplayCell(cell: PostTableViewCell, id: Int, index: Int) { }
}

extension AppDelegate: PostActionDelegate {

  func likeButtonDidPress(postID: Int) {

  }

  func commentsButtonDidPress(postID: Int) {

  }
}

extension AppDelegate: CommentInformationDelegate {

  func commentAuthorDidTap(commentID: Int) {
    print("Comment's author")
  }

  func commentReportButtonDidPress(commentID: Int) {
    print("Comment's report")
  }
}

extension AppDelegate: PostInformationDelegate {

  func likesInformationDidPress(postID: Int) {
    print("Likes")
  }

  func commentsInformationDidPress(postID: Int) {
    print("Comments")
    commentController.cachedHeights.removeAll()
    navigationController.pushViewController(commentController, animated: true)
  }

  func seenInformationDidPress(postID: Int) {
    print("Seen")
  }

  func authorDidTap(postID: Int) {
    print("Author")
  }

  func mediaDidTap(postID: Int, kind: Media.Kind, index: Int) {
    print("Index \(index)")
  }

  func groupDidTap(postID: Int) {

  }

  func reportButtonDidPress(postID: Int) {

  }
}
