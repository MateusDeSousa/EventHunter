import UIKit

protocol EventDetailViewModelDelegate: AnyObject {
    func dismissController()
    func presentController(_ controller: UIViewController)
    func getTableView() -> UITableView
    func getCoverImage() -> UIImageView
    func resetViews()
}
