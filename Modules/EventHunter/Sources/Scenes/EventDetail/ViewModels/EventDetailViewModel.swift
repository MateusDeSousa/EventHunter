import UIKit
import mNetwork
import MapKit
import CoreLocation

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
        guard let image = performScreenshot() else { return }
        let activityViewController = UIActivityViewController(activityItems: [model.title, image], applicationActivities: nil)
        delegate?.presentController(activityViewController)
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
    
    private func performScreenshot() -> UIImage? {
        guard let tableView = delegate?.getTableView(), let coverImage = delegate?.getCoverImage() else { return nil }
        var contentSize = tableView.contentSize
        contentSize.height += 80
        
        // save initial values
        let originalTableViewContentOffset = tableView.contentOffset
        tableView.contentOffset = CGPoint(x: 0, y: 0)
        tableView.frame = CGRect(origin: CGPoint(x: 0, y: 170), size: tableView.contentSize)
        tableView.backgroundColor = .clear
        
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.contentSize.width, height: contentSize.height))
        tempView.addSubview(coverImage)
        tempView.addSubview(tableView)
        
        let screenshot = buildScreenshot(with: tempView, contentSize: contentSize)
        
        tableView.contentOffset = originalTableViewContentOffset
        delegate?.resetViews()

        return screenshot
    }
    
    private func buildScreenshot(with view: UIView, contentSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(contentSize, false, UIScreen.main.scale)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        view.layer.render(in: currentContext)
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
