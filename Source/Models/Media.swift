import Foundation

public class Media {

  public enum Kind {
    case Image, Video
  }

  public var kind: Kind
  public var source: NSURL?
  public var thumbnail: NSURL?

  // MARK: - Initialization

  public init(kind: Kind, source: String, thumbnail: String? = nil) {
    self.kind = kind
    self.source = NSURL(string: source)
    self.thumbnail = NSURL(string: thumbnail ?? source)
  }
}
