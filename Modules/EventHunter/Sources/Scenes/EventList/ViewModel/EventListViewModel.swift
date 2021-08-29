import UIKit
import mNetwork
import mCore

final class EventListViewModel: EventListViewModelProtocol {
    
	private let api: APIRepository
	private var eventsModels: Set<EventModel>
	private var eventsOrdened: [EventModel]
	
	weak var delegate: EventListViewModelDelegate?
    
	init(apiRepository: APIRepository = APIRepository()) {
		self.api = apiRepository
		self.eventsModels = .init()
		self.eventsOrdened = .init()
	}
    
	func fetchData() {
        api.getAllEvents {[weak self] (result) in
			guard let self = self else { return }
			self.eventsOrdened.removeAll()
			do {
				let data = try result.get()
				let dataDecoded = try JSONDecoder().decode([EventModel].self, from: data)
				dataDecoded.forEach({ self.eventsModels.insert($0) })
				self.eventsOrdened.append(contentsOf: self.eventsModels.sorted(by: {$0.date > $1.date}))
				self.eventsOrdened.count > 0
						? self.delegate?.didLoadData()
						: self.delegate?.didLoadWithEmptyData()
			}catch {
				self.delegate?.didLoadWithError()
			}
        }
    }
    
	func getFilterActions() -> [UIAlertAction] {
        return [
			UIAlertAction(title: String(localized: "date"), style: .default, handler: {[weak self] _ in
				guard let self = self else { return }
				self.eventsOrdened = self.eventsModels.sorted(by: {$0.date > $1.date})
			}),
			UIAlertAction(title: String(localized: "price"), style: .default, handler: {[weak self] _ in
				guard let self = self else { return }
				self.eventsOrdened = self.eventsModels.sorted(by: {$0.price < $1.price})
			}),
			UIAlertAction(title: String(localized: "cancel"), style: .cancel, handler: nil)
		]
    }
	
}

extension EventListViewModel {
    
	func numberOfRows() -> Int {
		return eventsOrdened.count
	}
	
	func getCell(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "\(EventCardViewCell.self)") as! EventCardViewCell
		let event = eventsOrdened[indexPath.row]
		cell.config(urlCover: event.image, title: event.title, price: event.price, date: event.date)
		return cell
	}
	
	func didSelect(at indexPath: IndexPath) {
		let eventSelected = eventsOrdened[indexPath.row]
		let viewModel = EventDetailViewModel(model: eventSelected)
		let controller = EventDetailViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen
		delegate?.presentController(controller)
	}
    
}
