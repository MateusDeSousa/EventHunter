//
//  FormCheckinViewModel.swift
//  EventHunter
//
//  Created by Mateus Sousa on 16/12/20.
//

import UIKit

class FormCheckinViewModel: EventViewModel {
    
    var refController: UIViewController?
    var customView: UIView
    
    private let eventId: String
    
    init(eventId: String) {
        self.eventId = eventId
        self.customView = FormCheckinCustomView()
    }
    
    func viewDidLoad() {
        
    }
    
    func setupNavigation(_ navigation: UINavigationController?) {
        
    }
}
