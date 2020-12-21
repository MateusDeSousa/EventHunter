//
//  EventViewModel.swift
//  EventHunter
//
//  Created by Mateus Sousa on 14/12/20.
//

import UIKit
import mNetwork

protocol EventViewModel {
    var view: UIView { get set }
    var refController: UIViewController? { get set }
    
    func viewDidLoad()
    func viewDidAppear()
    func setupNavigation(_ navigation: UINavigationController?)
}

//MARK: - Optional implementation of life cycle methods
extension EventViewModel {
    func viewDidLoad() {}
    func viewDidAppear() {}
}

//MARK: - Optional implementation of additional methods
extension EventViewModel {
    func setupNavigation(_ navigation: UINavigationController?) {}
}
