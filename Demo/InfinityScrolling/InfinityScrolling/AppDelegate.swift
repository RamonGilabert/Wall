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
    controller.posts = self.generatePosts(1, to: 50)

    return controller
    }()

  let faker = Faker()
  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }

  func generatePosts(from: Int, to: Int) -> [Post] {
    var posts = [Post]()

    for i in from...to {
      var author = Author(name: "")

      if let imageURL = NSURL(string: "http://lorempixel.com/75/75?type=avatar&id=\(i)") {
        author = Author(name: faker.name.name(),
          avatar: imageURL)
      }

      var attachments = [NSURL]()
      var attachmentCount = 0
      var likes = 0
      var commentCount = 0
      var seen = 0

      if i % 4 == 0 {
        attachmentCount = 4
        commentCount = 3
        likes = 3
        seen = 4
      } else if i % 3 == 0 {
        attachmentCount = 2
        commentCount = 1
        likes = 1
        seen = 2
      } else if i % 2 == 0 {
        attachmentCount = 1
        commentCount = 4
        likes = 4
        seen = 6
      }

      for x in 0..<attachmentCount {
        if let imageURL = NSURL(string: "http://lorempixel.com/250/250/?type=attachment&id=\(i)\(x)") {
          attachments.append(imageURL)
        }
      }

      let sencenceCount = Int(arc4random_uniform(8) + 1)
      let post = Post(
        text: faker.lorem.sentences(amount: sencenceCount),
        publishDate: NSDate(timeIntervalSinceNow: -Double(arc4random_uniform(60000))),
        author: author,
        attachments: attachments
      )

      post.likeCount = likes
      post.seenCount = seen
      post.commentCount = commentCount
      posts.append(post)
    }
    
    return posts
  }
}

