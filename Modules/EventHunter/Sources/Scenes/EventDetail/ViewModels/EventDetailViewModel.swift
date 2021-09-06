import UIKit
import mNetwork
import MapKit
import CoreLocation

protocol EventDetailViewModelProtocol: AnyObject {
	var delegate: EventDetailViewModelDelegate? { get set }
	func closeBtnTapped()
	func shareBtnTapped()
	func getCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
	func numberOfRows() -> Int
	func willDisplay(_ tableView: UITableView, for cell: UITableViewCell, at indexPath: IndexPath)
	func takeCoverImageUrl() -> URL?
}

protocol EventDetailViewModelDelegate: AnyObject {
	func dismissController()
	func takeView() -> UIView
	func presentController(_ viewController: UIViewController, animated: Bool)
	func restoreSubviewsAfterScreenshot()
}

final class EventDetailViewModel: EventDetailViewModelProtocol {
    
    private let model: EventModel
	var delegate: EventDetailViewModelDelegate?
    
    init(model: EventModel) {
        self.model = model
    }
	
}

//MARK: - Actions
extension EventDetailViewModel {
	
	func closeBtnTapped() {
		delegate?.dismissController()
	}
	
	func shareBtnTapped() {
		guard let screenshotImage = processScreenshot() else { return }
		let activityViewController = UIActivityViewController(activityItems: [model.title, screenshotImage], applicationActivities: nil)
		delegate?.presentController(activityViewController, animated: true)
	}
	
	func takeCoverImageUrl() -> URL? {
		return model.image
	}
	
}

//MARK: - Setup tableView
extension EventDetailViewModel {
	
	func getCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
		let cell = DetailsEventViewCell()
		cell.config(title: model.title, price: model.price, description: model.description, date: model.date)
		return cell
	}
	
	func numberOfRows() -> Int {
		return 1
	}
	
	func willDisplay(_ tableView: UITableView, for cell: UITableViewCell, at indexPath: IndexPath) {
		if indexPath.row == 0 {
			cell.contentView.cornerRadius(of: 30, rectCorners: [.topLeft, .topRight])
			cell.cornerRadius(of: 30)
			cell.applyShadow(color: .black, opacity: 0.16, shadowOffset: CGSize(width: 0, height: -3), radius: 5)
		}
		cell.layer.zPosition = (CGFloat)(tableView.numberOfRows(inSection: 0) + indexPath.row)
	}
	
}

extension EventDetailViewModel {
	
	private func processScreenshot() -> UIImage? {
		guard let tableView = delegate?.takeView().subviews.first(where: { $0 is UITableView }) as? UITableView,
			  let coverImage = delegate?.takeView().subviews.first(where: { $0 is UIImageView }) as? UIImageView
		else { return nil }
		
		let initialOffset = tableView.contentOffset
		
		let size = getScreenshotSize(with: tableView)
		prepareForScreenshot(tableView)
		let imageResult = performScreenshot(of: [coverImage, tableView], contentSize: size)
		
		delegate?.restoreSubviewsAfterScreenshot()
		tableView.contentOffset = initialOffset
		
		return imageResult
	}
	
	private func getScreenshotSize(with tableView: UITableView) -> CGSize {
		var contentSize = tableView.contentSize
		contentSize.height += 80
		return contentSize
	}
	
	private func prepareForScreenshot(_ tableView: UITableView) {
		tableView.contentOffset = .zero
		tableView.frame = CGRect(x: 0, y: 170, width: tableView.contentSize.width, height: tableView.contentSize.height)
		tableView.backgroundColor = .clear
	}
	
	private func performScreenshot(of elements: [UIView], contentSize: CGSize) -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(contentSize, false, UIScreen.main.scale)
		let tempView = UIView()
		elements.forEach({ tempView.addSubview($0) })
		
		guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
		tempView.layer.render(in: currentContext)
		
		let result = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return result
	}
    
}

extension EventDetailViewModel: DetailsEventViewCellDelegate {
    
    func showLocationPressed() {
//        let viewModel = MapEventViewModel(latitude: model.latitude, longitude: model.longitude)
//        let controller = EventViewController(viewModel: viewModel)
//        refController?.present(controller, animated: true, completion: nil)
    }
    
    func checkinPressed() {
//        let controller = EventViewController(viewModel: FormCheckinViewModel(eventId: model.id))
//        refController?.present(controller, animated: true, completion: nil)
    }
}
