//
//  UIColorExtension.swift
//  mCore
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit

public extension UIColor {
    
    static var homeBackgroundColor: UIColor {
        let lightColor = UIColor(red: 245/255, green: 246/255, blue: 252/255, alpha: 1)
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection -> UIColor in
                traitCollection.userInterfaceStyle == .dark ? .black : lightColor
            }
        } else {
            return lightColor
        }
    }
    
    static var cardBackgroundColor: UIColor {
        if #available(iOS 13.0, *) {
            let darkColor = UIColor(red: 28/255, green: 28/255, blue: 30/255, alpha: 1)
            return UIColor { traitCollection -> UIColor in
                traitCollection.userInterfaceStyle == .dark ? darkColor : .white
            }
        } else {
            return .white
        }
    }
    
    static var labelColor: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
    
    static var secondaryLabelColor: UIColor {
        if #available(iOS 13.0, *) {
            return .label
        } else {
            return .black
        }
    }
}
