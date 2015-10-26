import UIKit
import Wall
import Fakery

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var wallController: WallController = { [unowned self] in
    let controller = WallController()
    controller.posts = self.generatePosts(1, to: 50)

    return controller
    }()

  let faker = Faker()

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    return true
  }

  func generatePosts(from: Int, to: Int) -> [Post] {
    var posts = [Post]()
    for i in from...to {
      let user = User(
        name: faker.name.name(),
        avatar: Image("http://lorempixel.com/75/75?type=avatar&id=\(i)"))
      var attachments = [AttachmentConvertible]()
      var comments = [PostConvertible]()
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
        attachments.append(Image("http://lorempixel.com/250/250/?type=attachment&id=\(i)\(x)"))
      }

      let sencenceCount = Int(arc4random_uniform(8) + 1)
      let post = Post(
        text: faker.lorem.sentences(amount: sencenceCount),
        publishDate: NSDate(timeIntervalSinceNow: -Double(arc4random_uniform(60000))),
        author: user,
        attachments: attachments
      )

      post.likeCount = likes
      post.seenCount = seen
      post.commentCount = commentCount

      for x in 0..<commentCount {
        let commentUser = User(
          name: faker.name.name(),
          avatar: Image("http://lorempixel.com/75/75/?type=avatar&id=\(i)\(x)"))
        let comment = Post(
          text: faker.lorem.sentences(amount: sencenceCount),
          publishDate: NSDate(timeIntervalSinceNow: -4),
          author: commentUser
        )
        comments.append(comment)
      }
      post.comments = comments

      posts.append(post)
    }
    
    return posts
  }
}

