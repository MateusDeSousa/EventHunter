import UIKit

protocol EventDetailViewModelProtocol: AnyObject {
    var delegate: EventDetailViewModelDelegate? { get set }
    func closeBtnTapped()
    func shareBtnTapped()
    func getCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func numberOfRows() -> Int
    func willDisplay(_ tableView: UITableView, for cell: UITableViewCell, at indexPath: IndexPath)
    func takeCoverImageUrl() -> URL?
}
