//
//  MapEventCustomView.swift
//  EventHunter
//
//  Created by Mateus Sousa on 16/12/20.
//

import UIKit
import mCore
import MapKit

protocol MapEventCustomViewDelegate {
    func closeButtonPressed()
    func didChangeTextSearchBar(_ text: String)
}

class MapEventCustomView: UIView {
    
    private let closeButton: CircleButtonView = {
        let button = CircleButtonView()
        button.setup(type: .close)
        return button
    }()
    
    public let mapView: MKMapView = {
        let mapview = MKMapView()
        mapview.translatesAutoresizingMaskIntoConstraints = false
        return mapview
    }()
    
    private let searchBarTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Ponto de partida"
        return textField
    }()
    
    var delegate: MapEventCustomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubviews()
        setupAnchors()
        closeButton.setPositionTopLeft()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(true)
    }
    
    private func setupView() {
        backgroundColor = .cardBackgroundColor
        closeButton.addTarget(self, action: #selector(onTapCloseButton), for: .touchUpInside)
        searchBarTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .valueChanged)
    }
    
    private func addSubviews() {
        addSubview(mapView)
        addSubview(closeButton)
        addSubview(searchBarTextField)
    }
    
    private func setupAnchors() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchBarTextField.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 20),
            searchBarTextField.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            searchBarTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            searchBarTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func onTapCloseButton() {
        delegate?.closeButtonPressed()
    }
    
    @objc private func textFieldDidChange(_ sender: UITextField) {
        delegate?.didChangeTextSearchBar(sender.text!)
    }
}
