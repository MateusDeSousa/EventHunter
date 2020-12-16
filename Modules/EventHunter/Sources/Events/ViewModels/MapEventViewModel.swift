//
//  MapEventViewModel.swift
//  EventHunter
//
//  Created by Mateus Sousa on 16/12/20.
//

import UIKit
import MapKit

class MapEventViewModel: NSObject, EventViewModel {
    
    var refController: UIViewController?
    var customView: UIView
    
    private let initialCoordinate: CLLocationCoordinate2D
    private let initialLocation: CLLocation
    
    init(latitude: Double, longitude: Double) {
        self.initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        self.initialCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.customView = MapEventCustomView()
    }
    
    func viewDidLoad() {
        setViewDelegate()
        centerToLocation(initialLocation)
    }
    
    func viewDidAppear() {
        setPointLocation(initialCoordinate)
    }
    
    func setupNavigation(_ navigation: UINavigationController?) {
        
    }
    
    private func setViewDelegate() {
        (customView as? MapEventCustomView)?.delegate = self
    }
    
    func centerToLocation( _ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        (customView as? MapEventCustomView)?.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setPointLocation(_ coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        (customView as? MapEventCustomView)?.mapView.addAnnotation(annotation)
    }
}

extension MapEventViewModel: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        
    }
}

extension MapEventViewModel: MapEventCustomViewDelegate {
    func closeButtonPressed() {
        
    }
    
    func didChangeTextSearchBar(_ text: String) {
        
    }
    
    
}
