import Foundation

public class Media {

  public var source: NSURL?
  public var thumbnail: NSURL?

  public init(source: String, thumbnail: String) {
    self.source = NSURL(string: source)
    self.thumbnail = NSURL(string: thumbnail)
  }
}
