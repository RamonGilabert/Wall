import UIKit

public protocol WallControllerDelegate: class {

  func shouldFetchMoreInformation()
  func shouldRefreshPosts(refreshControl: UIRefreshControl)
  func shouldDisplayDetail(postID: Int)
}

public class WallController: UIViewController {

  private var cells = [String: WallTableViewCell.Type]()

  public lazy var tableView: UITableView = { [unowned self] in
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.frame = self.view.bounds
    tableView.separatorStyle = .None
    tableView.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1)
    tableView.opaque = true

    return tableView
    }()

  public lazy var loadingIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
    activityIndicator.frame.origin.x = (UIScreen.mainScreen().bounds.width - 20) / 2
    activityIndicator.backgroundColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1)

    return activityIndicator
    }()

  public lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "handleRefreshControl:", forControlEvents: .ValueChanged)
    refreshControl.opaque = true

    return refreshControl
    }()

  public weak var delegate: WallControllerDelegate?
  public weak var actionDelegate: PostActionDelegate?
  public weak var informationDelegate: PostInformationDelegate?
  public weak var activityDelegate: PostActivityDelegate?
  private var posts = [Post]()
  public var fetching = true
  public var verticalOffset: CGFloat = 20
  public var cachedHeights = [Int : CGFloat]()

  // MARK: - View Lifecycle

  public override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(tableView)
    [refreshControl, loadingIndicator].forEach { tableView.addSubview($0) }
    tableView.sendSubviewToBack(refreshControl)
    refreshControl.subviews.first?.frame.origin.y = -5

    registerCell(PostTableViewCell.self,
      reusableIdentifier: PostTableViewCell.reusableIdentifier)

    view.backgroundColor = UIColor.whiteColor()
    view.layer.opaque = true

    tableView.contentInset.top = verticalOffset
    tableView.contentInset.bottom = verticalOffset
    tableView.scrollIndicatorInsets.top = tableView.contentInset.top - verticalOffset
  }

  public override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    fetching = false
  }

  // MARK: - Configuration

  public func registerCell<T: WallTableViewCell>(cellClass: T.Type, reusableIdentifier: String) {
    tableView.registerClass(cellClass,
      forCellReuseIdentifier: reusableIdentifier)
    cells[reusableIdentifier] = cellClass
  }

  public func initializePosts(newPosts: [PostConvertible]) {
    posts = []
    newPosts.forEach {
      posts.append($0.wallModel)
    }
  }

  public func appendPosts(newPosts: [PostConvertible]) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [unowned self] in
      var indexPaths = [NSIndexPath]()
      let count = self.posts.count

      for (index, post) in newPosts.enumerate() {
        indexPaths.append(NSIndexPath(forRow: count + index, inSection: 0))
        self.posts.append(post.wallModel)
      }

      dispatch_async(dispatch_get_main_queue()) {
        self.loadingIndicator.stopAnimating()
        self.tableView.beginUpdates()
        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .None)
        self.tableView.endUpdates()
        self.fetching = newPosts.isEmpty ? true : false
      }
    }
  }

  // MARK: - Refresh Control

  public func handleRefreshControl(refreshControl: UIRefreshControl) {
    tableView.beginUpdates()
    tableView.reloadData()
    tableView.endUpdates()
    delegate?.shouldRefreshPosts(refreshControl)
  }
}

// MARK: - WallTableViewCellDelegate

extension WallController: WallTableViewCellDelegate {

  public func updateCellSize(postID: Int, liked: Bool) {
    guard let postIndex = posts.indexOf({ $0.id == postID }) else { return }

    cachedHeights.removeValueForKey(postIndex)
    tableView.beginUpdates()
    tableView.endUpdates()
  }

  public func shouldDisplayDetail(postID: Int) {
    delegate?.shouldDisplayDetail(postID)
  }
}

// MARK: - UITableViewDelegate

extension WallController: UITableViewDelegate {

  public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if let height = cachedHeights[indexPath.row] {
      return height
    } else {
      let post = posts[indexPath.row]
      var CellClass = WallTableViewCell.self

      if let RegisteredCellClass = cells[post.reusableIdentifier] {
        CellClass = RegisteredCellClass
      }

      cachedHeights[indexPath.row] = CellClass.height(post)

      return CellClass.height(post)
    }
  }

  public func scrollViewDidScroll(scrollView: UIScrollView) {
    let currentOffset = scrollView.contentOffset.y
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

    if maximumOffset - currentOffset <= 1200 && !fetching {
      delegate?.shouldFetchMoreInformation()
      loadingIndicator.frame.origin.y = tableView.contentSize.height - 10
      loadingIndicator.startAnimating()
      fetching = true
    }
  }
}

// MARK: - UITableViewDataSource

extension WallController: UITableViewDataSource {

  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }

  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let post = posts[indexPath.row]
    var wallCell: WallTableViewCell?

    if let registeredCell = tableView.dequeueReusableCellWithIdentifier(post.reusableIdentifier) as? WallTableViewCell {
      wallCell = registeredCell
      if let postCell = wallCell as? PostTableViewCell {
        postCell.actionDelegate = actionDelegate
        postCell.informationDelegate = informationDelegate
        postCell.activityDelegate = activityDelegate
      }
    }

    guard let cell = wallCell else { return PostTableViewCell() }

    cell.configureCell(post)
    cell.delegate = self

    return cell
  }
}
