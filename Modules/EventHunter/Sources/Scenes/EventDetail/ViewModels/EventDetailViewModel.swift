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
    
    func shareButtonPressed() {
//        guard let image = screenshot() else { return }
//        let activityViewController = UIActivityViewController(activityItems: [model.title, image], applicationActivities: nil)
//        refController?.present(activityViewController, animated: true, completion: nil)
    }
    
//    func screenshot() -> UIImage? {
//        let tableView = customView.detailsTableView
//        let imageCover = customView.coverImageView
//
//        var contentSize = tableView.contentSize
//        contentSize.height += 80
//        UIGraphicsBeginImageContextWithOptions(contentSize, false, UIScreen.main.scale)
//
//        // save initial values
//        let savedContentOffset = tableView.contentOffset
//
//        tableView.contentOffset = CGPoint(x: 0, y: 0)
//        tableView.frame = CGRect(x: 0, y: 170, width: tableView.contentSize.width, height: tableView.contentSize.height)
//        customView.detailsTableView.backgroundColor = UIColor.clear
//
//        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.contentSize.width, height: contentSize.height))
//
//        tempView.addSubview(imageCover)
//        tempView.addSubview(tableView)
//
//        tempView.layer.render(in: UIGraphicsGetCurrentContext()!)
//
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//
//        // and return everything back
//        customView.insertSubview(imageCover, at: 0)
//        customView.insertSubview(tableView, at: 1)
//
//        // restore saved settings
//        tableView.contentOffset = savedContentOffset
//        customView.restoreConstraints()
//
//        UIGraphicsEndImageContext();
//        return image
//    }
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
