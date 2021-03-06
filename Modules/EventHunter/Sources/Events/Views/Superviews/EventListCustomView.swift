//
//  EventListCustomView.swift
//  EventHunter
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit

class EventListCustomView: UIView {
    
    //MARK: UI Components
    public let eventTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(EventCardViewCell.self, forCellReuseIdentifier: "\(EventCardViewCell.self)")
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private lazy var emptyStateImage: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    
    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .labelColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
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
    
    //MARK: Functions to build components in the view
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
            eventTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    //MARK: Setup component tableView
    public func setupTableView(delegate: UITableViewDelegate, datasource: UITableViewDataSource) {
        eventTableView.delegate = delegate
        eventTableView.dataSource = datasource
    }
    
    public func reloadTableView() {
        eventTableView.reloadData()
        eventTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}


extension EventListCustomView {
    
    public func buildViewError(_ error: ErrorType) {
        eventTableView.isHidden = true
        emptyStateImage.image = error.getImage()
        emptyStateLabel.text = error.getMessage()
        
        addSubviewsError()
        setupAnchorsError()
    }
    
    private func addSubviewsError() {
        addSubview(emptyStateImage)
        addSubview(emptyStateLabel)
    }
    
    private func setupAnchorsError() {
        NSLayoutConstraint.activate([
            emptyStateImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
            emptyStateImage.heightAnchor.constraint(equalToConstant: 200),
            emptyStateImage.widthAnchor.constraint(equalToConstant: 200),
            
            emptyStateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            emptyStateLabel.topAnchor.constraint(equalTo: emptyStateImage.bottomAnchor, constant: 50),
            emptyStateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)
        ])
    }
}

extension EventListCustomView {
    
    enum ErrorType {
        case notFoundData
        case errorJson
        
        func getImage() -> UIImage? {
            switch self {
            case .notFoundData:
                return UIImage(named: "noFoundNetwork")
            case .errorJson:
                return UIImage(named: "noFoundNetwork")
            }
        }
        
        func getMessage() -> String {
            switch self {
            case .notFoundData:
                return NSLocalizedString("empty-state-message", comment: "")
            case .errorJson:
                return NSLocalizedString("empty-state-message", comment: "")
            }
        }
    }
}
