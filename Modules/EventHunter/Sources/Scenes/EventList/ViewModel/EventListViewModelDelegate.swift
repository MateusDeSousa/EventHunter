import Foundation

protocol EventListViewModelDelegate: AnyObject {
	func didLoadWithError()
	func didLoadData()
	func didLoadWithEmptyData()
}
