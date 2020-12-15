//
//  EventViewController.swift
//  EventHunter
//
//  Created by Mateus Sousa on 14/12/20.
//

import UIKit

class EventViewController: UIViewController {
    
    private let eventTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(EventCardViewCell.self, forCellReuseIdentifier: "\(EventCardViewCell.self)")
        return tableView
    }()
    
    private var viewModel: EventViewModel
    
    init(viewModel: EventViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupAnchors()
        setupTableView()
        viewModel.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        viewModel.setupNavigation(navigationController)
        viewModel.setupView(view)
    }
    
    private func addSubviews() {
        view.addSubview(eventTableView)
    }
    
    private func setupAnchors() {
        NSLayoutConstraint.activate([
            eventTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            eventTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        eventTableView.delegate = self
        eventTableView.dataSource = self
        viewModel.reloadData = {[weak self] in
            self?.eventTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.loadCell(tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
