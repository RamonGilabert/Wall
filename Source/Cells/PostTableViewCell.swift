import UIKit

class WallPostTableViewCell: UITableViewCell {

  lazy var postImagesView: PostImagesView = {
    let view = PostImagesView()
    return view
    }()

  lazy var informationView: PostInformationBarView = {
    let view = PostInformationBarView()
    return view
    }()

  lazy var actionBarView: PostActionBarView = {
    let view = PostActionBarView()
    return view
    }()
}
