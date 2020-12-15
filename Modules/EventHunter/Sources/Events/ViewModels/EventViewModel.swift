//
//  EventViewModel.swift
//  EventHunter
//
//  Created by Mateus Sousa on 14/12/20.
//

import UIKit
import RxSwift
import mNetwork

protocol EventViewModel {
    var events: [EventModel] {get set}
    func viewDidLoad()
    var reloadData: (() -> Void)? { get set }
    func setupNavigation(_ navigation: UINavigationController?)
    func setupView(_ view: UIView)
    func numberOfRows() -> Int
    func loadCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelect(at indexPath: IndexPath)
}

extension EventViewModel {
    var events: [EventModel] {
        get { events }
        set { events = newValue}
    }
    func didSelect(at indexPath: IndexPath) {}
}
