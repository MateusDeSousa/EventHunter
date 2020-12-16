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
}

class DetailsEventCustomView: UIView {
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "iconClose"), for: .normal)
        button.backgroundColor = .systemBlue
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.cornerRadius(of: 16)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "iconShare"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.tintColor = .white
        button.cornerRadius(of: 16)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private let coverImageView: CachedImageView = {
        let imageView = CachedImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let detailsTableView: UITableView = {
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .cardBackgroundColor
        closeButton.addTarget(self, action: #selector(onTapCloseButton), for: .touchUpInside)
    }
    
    private func addSubviews() {
        addSubview(coverImageView)
        addSubview(detailsTableView)
        addSubview(closeButton)
        addSubview(shareButton)
    }
    
    private func setupAnchors() {
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            
            shareButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            shareButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            shareButton.heightAnchor.constraint(equalToConstant: 32),
            shareButton.widthAnchor.constraint(equalToConstant: 32),
            
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
}
