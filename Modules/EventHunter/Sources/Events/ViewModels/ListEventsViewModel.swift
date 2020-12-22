//
//  ListEventsViewModel.swift
//  EventHunter
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit
import mNetwork
import mCore

class ListEventsViewModel: NSObject, EventViewModel, CustomViewManager {
    
    typealias CustomView = EventListCustomView
    
    var view: UIView
    weak var refController: UIViewController?
    private let api = APIRepository()
    var events: [EventModel] = [EventModel]()
    
    override init() {
        self.view = EventListCustomView()
    }
    
    //MARK: Lifecycle view
    func viewDidLoad() {
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        customView.setupTableView(delegate: self, datasource: self)
    }
    
    private func reloadTableView() {
        customView.reloadTableView()
    }
    
    private func fetchData() {
        api.getAllEvents {[weak self] (result) in
            switch result {
            case .success(let data):
                do {
                    let listEvents = try JSONDecoder().decode([EventModel].self, from: data)
                    self?.events = listEvents
                } catch {
                    self?.customView.buildViewError(.notFoundData)
                }
                self?.reloadTableView()
            case .failure(_):
                self?.customView.buildViewError(.notFoundData)
            }
        }
    }
    
    func setupNavigation(_ navigation: UINavigationController?) {
        navigation?.topViewController?.title = NSLocalizedString("events", comment: "")
        if #available(iOS 11.0, *) {
            navigation?.navigationBar.prefersLargeTitles = true
        }
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "iconSorting"), style: .done, target: self, action: #selector(onTapFilterButton(_:)))
        navigation?.topViewController?.navigationItem.rightBarButtonItem = filterButton
        navigation?.navigationBar.tintColor = .labelColor
    }
    
    @objc private func onTapFilterButton(_ sender: UIBarButtonItem) {
        let sortActionSheet = UIAlertController(title: NSLocalizedString("order-by", comment: ""), message: nil, preferredStyle: .actionSheet)
        sortActionSheet.addAction(UIAlertAction(title: NSLocalizedString("date", comment: ""), style: .default, handler: {[weak self] _ in
            self?.events.sort(by: {$0.date > $1.date})
            self?.reloadTableView()
        }))
        sortActionSheet.addAction(UIAlertAction(title: NSLocalizedString("price", comment: ""), style: .default, handler: {[weak self] _ in
            self?.events.sort(by: {$0.price < $1.price})
            self?.reloadTableView()
        }))
        sortActionSheet.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
        refController?.present(sortActionSheet, animated: true, completion: nil)
    }
}

extension ListEventsViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(EventCardViewCell.self)") as! EventCardViewCell
        let event = events[indexPath.row]
        cell.config(urlCover: event.image, title: event.title, price: event.price, date: event.date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventSelected = events[indexPath.row]
        let viewModel = DetailsEventViewModel(model: eventSelected)
        let controller = EventViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen
        refController?.present(controller, animated: true, completion: nil)
    }
}
