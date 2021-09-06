import UIKit

protocol EventDetailViewModelDelegate: AnyObject {
    func dismissController()
	func takeView() -> UIView
	func presentController(_ viewController: UIViewController, animated: Bool)
	func restoreSubviewsAfterScreenshot()
}
