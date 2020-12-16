//
//  UIAlertControllerExtension.swift
//  mCore
//
//  Created by Mateus Sousa on 16/12/20.
//

import UIKit

public extension UIAlertController{
    
    @nonobjc func configPopoverAlert(_ sourceView: UIView? = nil, barButton: UIBarButtonItem? = nil, sourceRect: CGRect? = nil, direction: UIPopoverArrowDirection? = nil, delegate: UIPopoverPresentationControllerDelegate? = nil) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            modalPresentationStyle = UIModalPresentationStyle.popover
            let popoverPresenter = popoverPresentationController
            popoverPresenter?.barButtonItem = barButton
            popoverPresenter?.sourceView = sourceView
            
            if let sourceRect = sourceRect {
                popoverPresenter?.sourceRect = sourceRect
            }
            
            if let delegate = delegate {
                popoverPresenter?.delegate = delegate
            }
            
            popoverPresenter?.permittedArrowDirections  = direction ?? .up
        }
    }
}
