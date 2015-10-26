import UIKit

class Post {

  var id = 0
  var publishDate = NSDate()
  var text = ""
  var liked = false
  var seen = false
  var likeCount = 0
  var seenCount = 0
  var commentCount = 0
  var images = [UIImage]()
  var author: Author?

  init(text: String = "", publishDate: NSDate, author: Author? = nil,
    attachments: [UIImage] = []) {
      self.text = text
      self.publishDate = publishDate
      self.author = author
      self.images = attachments
  }
}
