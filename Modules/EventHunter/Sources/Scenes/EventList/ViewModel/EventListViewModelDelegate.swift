import UIKit

protocol EventListViewModelDelegate: AnyObject {
	func didLoadWithError()
	func didLoadData()
	func didLoadWithEmptyData()
	func presentController(_ controller: UIViewController)
}
