//
//  EventListCustomView.swift
//  EventHunter
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit

class EventListCustomView: UIView {
    
    private let eventTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(EventCardViewCell.self, forCellReuseIdentifier: "\(EventCardViewCell.self)")
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
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
        backgroundColor = .homeBackgroundColor
    }
    
    private func addSubviews() {
        addSubview(eventTableView)
    }
    
    private func setupAnchors() {
        NSLayoutConstraint.activate([
            eventTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventTableView.topAnchor.constraint(equalTo: topAnchor),
            eventTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func setupTableView(delegate: UITableViewDelegate, datasource: UITableViewDataSource) {
        eventTableView.delegate = delegate
        eventTableView.dataSource = datasource
    }
    
    public func reloadTableView() {
        eventTableView.reloadData()
        eventTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}
