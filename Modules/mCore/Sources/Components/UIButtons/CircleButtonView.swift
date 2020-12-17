//
//  CircleButtonView.swift
//  mCore
//
//  Created by Mateus Sousa on 16/12/20.
//

import UIKit

public class CircleButtonView: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        tintColor = .white
        backgroundColor = .systemBlue
        cornerRadius(of: 16)
        heightAnchor.constraint(equalToConstant: 32).isActive = true
        widthAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(type: TypeImageButton) {
        setImage(type.getImage(), for: .normal)
        imageEdgeInsets = type.getImageEdgeInsets()
    }
    
    public func setPositionTopLeft() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 25).isActive = true
        topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: 15).isActive = true
    }
    
    public func setPositionTopRight() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -25).isActive = true
        topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor, constant: 15).isActive = true
    }
}

public enum TypeImageButton {
    case close
    case share
    
    func getImage() -> UIImage? {
        switch self {
        case .close:
            return UIImage(named: "imageClose", in: Bundle(for: CircleButtonView.self), compatibleWith: nil)
        case .share:
            return UIImage(named: "iconShare", in: Bundle(for: CircleButtonView.self), compatibleWith: nil)
        }
    }
    
    func getImageEdgeInsets() -> UIEdgeInsets {
        switch self {
        case .close:
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        case .share:
            return UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        }
    }
}
