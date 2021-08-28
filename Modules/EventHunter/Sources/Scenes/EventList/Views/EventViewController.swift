import UIKit

final class EventListViewController: UITableViewController {
    
	private let customRefreshControl = UIRefreshControl()
    private var viewModel: EventListViewModelProtocol
    
    init(viewModel: EventListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Lifecicle
extension EventListViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.delegate = self
		setupNatigationBar()
		setupTableView()
		viewModel.fetchData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.sizeToFit()
	}
	
}

//MARK: - Setup
extension EventListViewController {
	
	private func setupNatigationBar() {
		title = String(localized: "events")
		if #available(iOS 11.0, *) {
			navigationController?.navigationBar.prefersLargeTitles = true
		}
		
		let filterButton = UIBarButtonItem(image: UIImage(named: "iconSorting"), style: .done, target: self, action: #selector(onFilterBtnTapped))
		navigationItem.rightBarButtonItem = filterButton
		navigationController?.navigationBar.tintColor = .labelColor
	}
	
	private func setupTableView() {
		tableView.register(EventCardViewCell.self, forCellReuseIdentifier: String(describing: EventCardViewCell.self))
		tableView.tableFooterView = UIView()
		tableView.separatorStyle = .none
		refreshControl = UIRefreshControl()
		refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
	}
	
}

//MARK: - Actions
extension EventListViewController {
	
	@objc private func onFilterBtnTapped() {
		let actionSheet = UIAlertController(title: String(localized: "order-by"),
													message: nil,
													preferredStyle: .actionSheet)
		viewModel.getFilterActions().forEach({ actionSheet.addAction($0) })
		present(actionSheet, animated: true, completion: nil)
	}
	
	@objc func refresh(_ sender: Any) {
		viewModel.fetchData()
	}
	
}

//MARK: - EventListViewModelDelegate
extension EventListViewController: EventListViewModelDelegate {
	
	func didLoadData() {
		tableView.backgroundView = nil
		tableView.reloadData()
		refreshControl?.endRefreshing()
	}
	
	func didLoadWithError() {
		tableView.reloadData()
		tableView.backgroundView = ErrorView(illustration: UIImage(named: "noFoundNetwork"),
											 message: String(localized: "empty-state-message"))
		refreshControl?.endRefreshing()
	}
	
	func didLoadWithEmptyData() {
		tableView.reloadData()
		tableView.backgroundView = ErrorView(illustration: UIImage(named: "noFoundNetwork"),
											 message: String(localized: "empty-state-message"))
		refreshControl?.endRefreshing()
	}
	
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension EventListViewController {
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.numberOfRows()
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		viewModel.getCell(in: tableView, at: indexPath)
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.didSelect(at: indexPath)
	}
	
}
