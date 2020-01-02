//
//  UserLocationViewController.swift
//  Random Users
//
//  Created by Rinalds Domanovs on 02/01/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import UIKit
import MapKit

class UserLocationViewController: UIViewController {

    // MARK: - Properties
    var mapView: MKMapView!
    var name: String! {
        didSet {
            title = name
        }
    }
    var longitude: String!
    var latitude: String!

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Custom methods
    func setupUI() {
        self.view.backgroundColor = .white
        setupMapView()
    }

    func setupMapView() {
        mapView = MKMapView()
          mapView.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(mapView)

          let constraints = [
              mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
              mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
              mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
          ]

        NSLayoutConstraint.activate(constraints)

        mapView.delegate = self

        let lat = (latitude as NSString).doubleValue
        let lon = (longitude as NSString).doubleValue
        let locationCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        let userLocation = UserLocation(title: name, coordinate: locationCoordinate)
        mapView.setCenter(locationCoordinate, animated: true)
        mapView.addAnnotation(userLocation)
    }
}

// MARK: - Delegates
extension UserLocationViewController: MKMapViewDelegate {

}

// MARK: - UserLocation Annotation
class UserLocation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate

        super.init()
    }
}
