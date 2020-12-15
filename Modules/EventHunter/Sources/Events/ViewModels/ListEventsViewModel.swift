//
//  ListEventsViewModel.swift
//  EventHunter
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit
import mNetwork
import mCore

class ListEventsViewModel: EventViewModel {
    
    private let api = APIRepository()
    var events: [EventModel] = [EventModel]()
    var reloadData: (() -> Void)?
    
    func viewDidLoad() {
        fetchData()
    }
    
    private func fetchData() {
        api.getAllEvents {[weak self] (result) in
            switch result {
            case .success(let events):
                self?.events = events
                self?.reloadData?()
            case .failure(_):
                break
            }
        }
    }
    
    func setupNavigation(_ navigation: UINavigationController?) {
        navigation?.topViewController?.title = "Eventos"
        navigation?.navigationBar.prefersLargeTitles = true
    }
    
    func setupView(_ view: UIView) {
        view.backgroundColor = .homeBackgroundColor
    }
    
    func numberOfRows() -> Int {
        return events.count
    }
    
    func loadCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(EventCardViewCell.self)") as! EventCardViewCell
        let event = events[indexPath.row]
        cell.config(urlCover: URL(string: event.image), title: event.title, price: event.price, date: event.date)
        return cell
    }
    
    func didSelect(at indexPath: IndexPath) {
        
    }
}
