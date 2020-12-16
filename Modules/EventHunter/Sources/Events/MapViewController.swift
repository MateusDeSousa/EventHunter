//
//  MapViewController.swift
//  EventHunter
//
//  Created by Mateus Sousa on 16/12/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "iconClose"), for: .normal)
        button.backgroundColor = .systemBlue
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.cornerRadius(of: 16)
        return button
    }()
    
    private let mapView: MKMapView = {
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
    
    private let initialCoordinate: CLLocationCoordinate2D
    private let initialLocation: CLLocation
    private let completer = MKLocalSearchCompleter()
    
    init(latitude: Double, longitude: Double) {
        self.initialCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupAnchors()
        setPointLocation()
        completer.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerToLocation(initialLocation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func setupView() {
        view.backgroundColor = .cardBackgroundColor
        closeButton.addTarget(self, action: #selector(onTapCloseButton), for: .touchUpInside)
        searchBarTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .valueChanged)
    }
    
    private func addSubviews() {
        view.addSubview(mapView)
        view.addSubview(closeButton)
        view.addSubview(searchBarTextField)
    }
    
    private func setupAnchors() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            
            searchBarTextField.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 20),
            searchBarTextField.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            searchBarTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBarTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func centerToLocation( _ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setPointLocation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialCoordinate
        mapView.addAnnotation(annotation)
    }
    
    @objc private func onTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
}

extension MapViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        
    }
}

extension MapViewController: MKLocalSearchCompleterDelegate {
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    guard let _ = completer.results.first else {
      return
    }
  }

  func completer( _ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    
  }
}
