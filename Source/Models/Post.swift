import Foundation

public protocol PostConvertible {

  var wallModel: Post { get }
}

public class Post {

  public var id = 0
  public var publishDate = ""
  public var text = ""
  public var liked = false
  public var seen = false
  public var likeCount = 0
  public var seenCount = 0
  public var commentCount = 0
  public var author: Author?

  public var media: [Media]

  // MARK: - Initialization

  public init(text: String = "", publishDate: String,
    author: Author? = nil, media: [Media] = []) {
      self.text = text
      self.publishDate = publishDate
      self.author = author
      self.media = media
  }
}

// MARK: - PostConvertible

extension Post: PostConvertible {

  public var wallModel: Post {
    return self
  }
}
