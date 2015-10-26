import UIKit

class WallController: UIViewController {

  lazy var tableView: UITableView = { [unowned self] in
    let tableView = UITableView()
    tableView.registerClass(PostTableViewCell.self,
      forCellReuseIdentifier: PostTableViewCell.reusableIdentifier)
    tableView.delegate = self
    tableView.dataSource = self

    return tableView
    }()

  var posts = [Post]()

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension WallController: UITableViewDelegate {

  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 80
  }
}

extension WallController: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCellWithIdentifier(PostTableViewCell.reusableIdentifier)
      as? PostTableViewCell else { return PostTableViewCell() }
    
    let post = posts[indexPath.row]

    cell.configureCell(post)

    return cell
  }
}
