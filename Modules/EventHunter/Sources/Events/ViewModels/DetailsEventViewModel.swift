//
//  DetailsEventViewModel.swift
//  EventHunter
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit
import mNetwork
import MapKit
import CoreLocation

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
        (customView as? DetailsEventCustomView)?.setCoverImage(model.image)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DetailsEventViewCell()
        cell.config(title: model.title, price: model.price, description: model.description, date: model.date)
        cell.delegate = self
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeightCoverImage(scrollView.contentOffset.y)
    }
}

extension DetailsEventViewModel: DetailsEventCustomViewDelegate {
    
    func closeButtonPressed() {
        refController?.dismiss(animated: true, completion: nil)
    }
    
    func shareButtonPressed() {
        guard let image = screenshot() else { return }
        let activityViewController = UIActivityViewController(activityItems: [model.title, image], applicationActivities: nil)
        refController?.present(activityViewController, animated: true, completion: nil)
    }
    
    func screenshot() -> UIImage? {
        guard let superview = customView as? DetailsEventCustomView else { return  nil }
        let tableView = superview.detailsTableView
        let imageCover = superview.coverImageView
        
        var contentSize = tableView.contentSize
        contentSize.height += 80
        UIGraphicsBeginImageContextWithOptions(contentSize, false, UIScreen.main.scale)
        
        // save initial values
        let savedContentOffset = tableView.contentOffset
        
        tableView.contentOffset = CGPoint(x: 0, y: 0)
        tableView.frame = CGRect(x: 0, y: 170, width: tableView.contentSize.width, height: tableView.contentSize.height)
        superview.detailsTableView.backgroundColor = UIColor.clear
        
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.contentSize.width, height: contentSize.height))
        
        tempView.addSubview(imageCover)
        tempView.addSubview(tableView)
        
        tempView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        // and return everything back
        superview.insertSubview(imageCover, at: 0)
        superview.insertSubview(tableView, at: 1)
        
        // restore saved settings
        tableView.contentOffset = savedContentOffset
        superview.restoreConstraints()
        
        UIGraphicsEndImageContext();
        return image
    }
}

extension DetailsEventViewModel: DetailsEventViewCellDelegate {
    
    func showLocationPressed() {
        let viewModel = MapEventViewModel(latitude: model.latitude, longitude: model.longitude)
        let controller = EventViewController(viewModel: viewModel)
        refController?.present(controller, animated: true, completion: nil)
    }
    
    func checkinPressed() {
        let controller = EventViewController(viewModel: FormCheckinViewModel(eventId: model.id))
        refController?.present(controller, animated: true, completion: nil)
    }
}
