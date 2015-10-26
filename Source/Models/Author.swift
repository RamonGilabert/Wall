import UIKit

class Author {

  var name: String
  var avatar: UIImage?

  init(name: String, avatar: UIImage? = nil) {
    self.name = name
    self.avatar = avatar
  }
}
