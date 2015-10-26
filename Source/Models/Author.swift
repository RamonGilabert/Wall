import UIKit

public class Author {

  public var name: String
  public var avatar: UIImage?

  public init(name: String, avatar: UIImage? = nil) {
    self.name = name
    self.avatar = avatar
  }
}
