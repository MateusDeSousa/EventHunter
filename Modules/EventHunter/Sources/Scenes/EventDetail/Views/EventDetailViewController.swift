import UIKit
import mCore

final class EventDetailViewController: UIViewController {
	
	private let viewModel: EventDetailViewModelProtocol
	
	private lazy var closeButton: CircleButtonView = {
		$0.setup(type: .close)
		$0.addTarget(self, action: #selector(onCloseButton), for: .touchUpInside)
		return $0
	}(CircleButtonView())
	
	private lazy var shareButton: CircleButtonView = {
		$0.setup(type: .share)
		$0.addTarget(self, action: #selector(onShareButton), for: .touchUpInside)
		return $0
	}(CircleButtonView())
	
	public let coverImageView: CachedImageView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.contentMode = .scaleAspectFill
		$0.clipsToBounds = true
		return $0
	}(CachedImageView(frame: .zero))
	
	public lazy var detailsTableView: UITableView = {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.separatorStyle = .none
		$0.backgroundColor = .clear
		$0.rowHeight = UITableView.automaticDimension
		$0.contentInset = UIEdgeInsets(top: 170, left: 0, bottom: 0, right: 0)
		$0.dataSource = self
		$0.delegate = self
		return $0
	}(UITableView())
	
	public lazy var detailsTableViewHeightAnchor: NSLayoutConstraint = {
		return coverImageView.heightAnchor.constraint(equalToConstant: 150)
	}()
	
	init(viewModel: EventDetailViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addSubviews() {
		view.addSubview(coverImageView)
		view.addSubview(detailsTableView)
		view.addSubview(closeButton)
		view.addSubview(shareButton)
	}
	
	private func setupAnchors() {
		closeButton.setPositionTopLeft()
		shareButton.setPositionTopRight()
		NSLayoutConstraint.activate([
			detailsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			detailsTableView.topAnchor.constraint(equalTo: view.topAnchor),
			detailsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			detailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			coverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			coverImageView.topAnchor.constraint(equalTo: view.topAnchor),
			coverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			detailsTableViewHeightAnchor
		])
	}
	
	private func setupController() {
		navigationController?.setNavigationBarHidden(true, animated: false)
		view.backgroundColor = .cardBackgroundColor
		coverImageView.loadImage(from: viewModel.takeCoverImageUrl(),
								 placeholderImage: UIImage(named: "emptyStateCover"))
	}
}

//MARK: - Lifecicle
extension EventDetailViewController {
	
	override func viewDidLoad() {
		viewModel.delegate = self
		setupController()
		addSubviews()
		setupAnchors()
	}
	
}

//MARK: - Actions
extension EventDetailViewController: EventDetailViewModelDelegate {
	
	@objc private func onCloseButton() {
		viewModel.closeBtnTapped()
	}
	
	@objc private func onShareButton() {
		viewModel.shareBtnTapped()
	}
	
	func dismissController() {
		dismiss(animated: true, completion: nil)
	}
	
    func presentController(_ controller: UIViewController) {
        present(controller, animated: true, completion: nil)
    }
    
    func getTableView() -> UITableView {
        return detailsTableView
    }
    
    func getCoverImage() -> UIImageView {
        return coverImageView
    }
    
    func resetViews() {
        view.insertSubview(coverImageView, at: 0)
        view.insertSubview(detailsTableView, at: 1)
        setupAnchors()
    }
    
}

//MARK: - UITableViewDataSource
extension EventDetailViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.numberOfRows()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		viewModel.getCell(in: tableView, at: indexPath)
	}
	
}

//MARK: - UITableViewDelegate
extension EventDetailViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		viewModel.willDisplay(tableView, for: cell, at: indexPath)
	}
	
}

//MARK: - ScrollView
extension EventDetailViewController {
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		updateHeightCoverImage(scrollView.contentOffset.y)
	}
	
	private func updateHeightCoverImage(_ contentOffset: CGFloat) {
		let constant: CGFloat = -contentOffset > 190 ? -contentOffset + 30 : 220
		detailsTableViewHeightAnchor.constant = constant
	}
	
}
