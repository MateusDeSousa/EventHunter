//
//  EventViewController.swift
//  EventHunter
//
//  Created by Mateus Sousa on 14/12/20.
//

import UIKit

class EventViewController: UIViewController {
    
    private var viewModel: EventViewModel
    
    init(viewModel: EventViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = viewModel.customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.refController = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setupNavigation(navigationController)
        navigationController?.navigationBar.sizeToFit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
}
