import UIKit
import MapKit

class MapEventViewModel: NSObject {
    
    typealias CustomView = MapEventCustomView
    
    var refController: UIViewController?
    var view: UIView
    
    private let initialCoordinate: CLLocationCoordinate2D
    private let initialLocation: CLLocation
    
    init(latitude: Double, longitude: Double) {
        self.initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        self.initialCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.view = MapEventCustomView()
    }
    
    //MARK: Lifecycle view
    func viewDidLoad() {
        setViewDelegate()
        centerToLocation(initialLocation)
    }
    
    func viewDidAppear() {
        setPointLocation(initialCoordinate)
    }
    
    func setupNavigation(_ navigation: UINavigationController?) { }
    
    private func setViewDelegate() {
//        customView.delegate = self
    }
    
    func centerToLocation( _ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
//        customView.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setPointLocation(_ coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
//        customView.mapView.addAnnotation(annotation)
    }
}

extension MapEventViewModel: MapEventCustomViewDelegate {
    func closeButtonPressed() {
        refController?.dismiss(animated: true, completion: nil)
    }
}
