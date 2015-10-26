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

    return tableView
    }()

  public var posts = [Post]()

  public override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(tableView)
    view.backgroundColor = UIColor.whiteColor()
  }
}

extension WallController: UITableViewDelegate {

  public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 80
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
