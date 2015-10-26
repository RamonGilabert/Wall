import UIKit

public class Post {

  public var id = 0
  public var publishDate = NSDate()
  public var text = ""
  public var liked = false
  public var seen = false
  public var likeCount = 0
  public var seenCount = 0
  public var commentCount = 0
  public var images = [UIImage]()
  public var author: Author?

  public init(text: String = "", publishDate: NSDate, author: Author? = nil,
    attachments: [UIImage] = []) {
      self.text = text
      self.publishDate = publishDate
      self.author = author
      self.images = attachments
  }
}
