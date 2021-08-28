import UIKit

protocol EventListViewModelProtocol {
	var delegate: EventListViewModelDelegate? { get set }
    func fetchData()
	func getFilterActions() -> [UIAlertAction]
	func getCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
	func numberOfRows() -> Int
	func didSelect(at indexPath: IndexPath)
}
