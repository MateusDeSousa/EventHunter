//
//  CustomViewManager.swift
//  EventHunter
//
//  Created by Mateus Sousa on 21/12/20.
//

import UIKit

protocol CustomViewManager {
    associatedtype CustomView: UIView
}

extension CustomViewManager where Self: EventViewModel {
    internal var customView: CustomView {
        guard let customView = view as? CustomView else {
            fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
        }
        return customView
    }
}
