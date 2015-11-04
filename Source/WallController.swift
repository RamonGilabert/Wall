import UIKit

public class WallController: UIViewController {

  public lazy var tableView: UITableView = { [unowned self] in
    let tableView = UITableView()
    tableView.registerClass(PostTableViewCell.self,
      forCellReuseIdentifier: PostTableViewCell.reusableIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.frame = CGRect(x: 0, y: 0,
      width: UIScreen.mainScreen().bounds.width,
      height: UIScreen.mainScreen().bounds.height)
    tableView.separatorStyle = .None
    tableView.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1)
    tableView.opaque = true

    return tableView
    }()

  public lazy var topSeparator: UIView = {
    let view = UIView()
    view.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 20)
    view.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1)
    view.opaque = true

    return view
    }()

  public var posts = [Post]()

  public override func viewDidLoad() {
    super.viewDidLoad()

    [topSeparator, tableView].forEach { view.addSubview($0) }

    view.backgroundColor = UIColor.whiteColor()
    view.layer.opaque = true

    if let navigationController = navigationController {
      tableView.contentInset.top = navigationController.navigationBar.frame.height
        + UIApplication.sharedApplication().statusBarFrame.height + 20
      tableView.scrollIndicatorInsets.top = tableView.contentInset.top - 20
    }
  }
}

extension WallController: UITableViewDelegate {

  public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let post = posts[indexPath.row]
    let postText = post.text as NSString
    let textFrame = postText.boundingRectWithSize(CGSize(width: UIScreen.mainScreen().bounds.width - 40,
      height: CGFloat.max), options: .UsesLineFragmentOrigin,
      attributes: [ NSFontAttributeName : UIFont.systemFontOfSize(14) ], context: nil)

    let imageHeight: CGFloat = post.images.isEmpty ? 0 : 274
    let totalHeight: CGFloat = imageHeight + 60 + 56 + 44 + 20 + 12 + textFrame.height

    return totalHeight
  }
}

extension WallController: UITableViewDataSource {

  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }

  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier(PostTableViewCell.reusableIdentifier)
      as? PostTableViewCell else { return PostTableViewCell() }

    let post = posts[indexPath.row]

    cell.configureCell(post)

    return cell
  }
}
