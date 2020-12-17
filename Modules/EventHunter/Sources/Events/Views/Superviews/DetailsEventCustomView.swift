//
//  DetailsEventCustomView.swift
//  EventHunter
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit
import mCore

protocol DetailsEventCustomViewDelegate{
    func closeButtonPressed()
    func shareButtonPressed()
}

class DetailsEventCustomView: UIView {
    
    //MARK: UI Components
    private let closeButton: CircleButtonView = {
        let button = CircleButtonView()
        button.setup(type: .close)
        return button
    }()
    
    private let shareButton: CircleButtonView = {
        let button = CircleButtonView()
        button.setup(type: .share)
        return button
    }()
    
    public let coverImageView: CachedImageView = {
        let imageView = CachedImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public let detailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 170, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    public lazy var detailsTableViewHeightAnchor: NSLayoutConstraint = {
        return coverImageView.heightAnchor.constraint(equalToConstant: 150)
    }()
    
    var delegate: DetailsEventCustomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubviews()
        setupAnchors()
        closeButton.setPositionTopLeft()
        shareButton.setPositionTopRight()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions to build components in the view
    private func setupView() {
        backgroundColor = .cardBackgroundColor
        closeButton.addTarget(self, action: #selector(onTapCloseButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(onShareButton), for: .touchUpInside)
    }
    
    private func addSubviews() {
        addSubview(coverImageView)
        addSubview(detailsTableView)
        addSubview(closeButton)
        addSubview(shareButton)
    }
    
    private func setupAnchors() {
        NSLayoutConstraint.activate([
            detailsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsTableView.topAnchor.constraint(equalTo: topAnchor),
            detailsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            coverImageView.topAnchor.constraint(equalTo: topAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailsTableViewHeightAnchor
        ])
    }
    
    public func restoreConstraints() {
        setupAnchors()
    }
    
    public func setupTableView(delegate: UITableViewDelegate, datasource: UITableViewDataSource) {
        detailsTableView.delegate = delegate
        detailsTableView.dataSource = datasource
    }
    
    public func reloadTableView() {
        detailsTableView.reloadData()
    }
    
    public func setCoverImage(_ url: URL?) {
        coverImageView.loadImage(from: url, placeholderImage: UIImage(named: "emptyStateCover"), successCompletion: nil)
    }
    
    @objc private func onTapCloseButton() {
        delegate?.closeButtonPressed()
    }
    
    @objc private func onShareButton() {
        delegate?.shareButtonPressed()
    }
}
