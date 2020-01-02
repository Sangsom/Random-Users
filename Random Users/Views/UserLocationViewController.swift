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

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: - Custom methods
    func setupUI() {
        self.view.backgroundColor = .white
        title = "Rino"

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
    }
}
