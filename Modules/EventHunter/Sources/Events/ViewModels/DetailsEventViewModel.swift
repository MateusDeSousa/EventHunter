//
//  DetailsEventViewModel.swift
//  EventHunter
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit
import mNetwork
import Hero

class DetailsEventViewModel: NSObject, EventViewModel {
    var customView: UIView
    
    weak var refController: UIViewController?
    
    private let model: EventModel
    var reloadData: (() -> Void)?
    
    init(model: EventModel) {
        self.model = model
        self.customView = DetailsEventCustomView()
    }
    
    func viewDidLoad() {
        loadCoverImage()
        setupView()
    }
    
    private func setupView() {
        let view = customView as? DetailsEventCustomView
        view?.setupTableView(delegate: self, datasource: self)
        view?.delegate = self
    }
    
    private func reloadTableView() {
        (customView as? DetailsEventCustomView)?.reloadTableView()
    }
    
    private func loadCoverImage() {
        (customView as? DetailsEventCustomView)?.setCoverImage(URL(string: model.image))
    }
    
    private func updateHeightCoverImage(_ contentOffset: CGFloat) {
        let constant: CGFloat = -contentOffset > 190 ? -contentOffset + 30 : 220
        (customView as? DetailsEventCustomView)?.detailsTableViewHeightAnchor.constant = constant
    }
    
    func setupNavigation(_ navigation: UINavigationController?) {
        navigation?.setNavigationBarHidden(true, animated: false)
    }
}

extension DetailsEventViewModel: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.contentView.cornerRadius(of: 30, rectCorners: [.topLeft, .topRight])
            cell.cornerRadius(of: 30)
            cell.applyShadow(color: .black, opacity: 0.16, shadowOffset: CGSize(width: 0, height: -3), radius: 5)
        }
        cell.layer.zPosition = (CGFloat)(tableView.numberOfRows(inSection: 0) + indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = DetailsEventViewCell()
            cell.config(title: model.title, price: model.price, description: model.description, date: model.date)
            return cell
        case 1:
            let cell = DetailsButtonsViewCell()
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeightCoverImage(scrollView.contentOffset.y)
    }
}

extension DetailsEventViewModel: DetailsEventCustomViewDelegate {
    
    func closeButtonPressed() {
        refController?.dismiss(animated: true, completion: nil)
    }
}

extension DetailsEventViewModel: DetailsButtonsViewCellDelegate {
    
    func showLocationPressed() {
        
    }
    
    func checkinPressed() {
        
    }
}
