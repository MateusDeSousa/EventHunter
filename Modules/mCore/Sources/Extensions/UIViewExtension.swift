//
//  UIViewExtension.swift
//  mCore
//
//  Created by Mateus Sousa on 15/12/20.
//

import UIKit

public extension UIView {
    
    func cornerRadius(of radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func cornerRadius(of radius: CGFloat, rectCorners: UIRectCorner) {
        clipsToBounds = true
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: rectCorners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    func applyShadow(color: UIColor = .black, opacity: Float = 0.1, shadowOffset: CGSize = CGSize(width: 0, height: 8), radius: CGFloat = 8) {
        layer.masksToBounds = false
        layer.shadowColor   = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset  = shadowOffset
        layer.shadowRadius  = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
	
	func applyShadowForRounded(color: UIColor = .black, opacity: Float = 0.16,
							   offset: CGSize = CGSize(width: 2, height: 2), radius: CGFloat = 5) {
		layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
		layer.shadowColor   = color.cgColor
		layer.shadowOpacity = opacity
		layer.shadowOffset  = offset
		layer.shadowRadius  = radius
		layer.masksToBounds = false
	}
}
