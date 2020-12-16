//
//  EventViewModel.swift
//  EventHunter
//
//  Created by Mateus Sousa on 14/12/20.
//

import UIKit
import RxSwift
import mNetwork

protocol EventViewModel {
    var refController: UIViewController? { get set }
    var customView: UIView { get set }
    var events: [EventModel] {get set}
    func viewDidLoad()
    func setupNavigation(_ navigation: UINavigationController?)
}

extension EventViewModel {
    var events: [EventModel] {
        get { events } set { events = newValue}
    }
}
