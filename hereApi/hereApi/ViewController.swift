//
//  ViewController.swift
//  hereApi
//
//  Created by Erica Geraldes on 15/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//
import Foundation
import UIKit
import NMAKit

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var searchBar: SearchBar?
    var resultsTableView: UITableView?
    var locationResults: [NMALink]?
    
    enum Constants {
        static let mapZoomDefault: Float = 13.2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureLocationManager()
    }
}

private extension ViewController {
    
    func configureLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func configureViews() {
        configureMapView()
        configureSearchBar()
        configureShortcutViews()
    }
    
    func configureSearchBar() {
        searchBar = SearchBar(delegate: self)
        guard let searchBar = searchBar else { return }
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Spacing.L).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func configureMapView() {
        
        let mapView = NMAMapView(frame: CGRect(x: 0, y: Spacing.XL, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.view.safeAreaLayoutGuide.layoutFrame.height / 2))
        
        self.view.addSubview(mapView)
        guard let location = locationManager.location else { return }
        let coords: NMAGeoCoordinates = NMAGeoCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        mapView.set(geoCenter: coords, animation: .none)
        mapView.zoomLevel = Constants.mapZoomDefault
    }
    
    func configureShortcutViews() {
        let restaurantView = ShortcutView(type: .restaurant, frame: CGRect.zero)
        self.view.addSubview(restaurantView)
        
        restaurantView.translatesAutoresizingMaskIntoConstraints = false
        restaurantView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: Spacing.L).isActive = true
        restaurantView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        restaurantView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        restaurantView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let results = LocationResultsTableViewController(style: .grouped)
        results.locationManager = self.locationManager
        searchBar.resignFirstResponder()
        self.navigationController?.pushViewController(results, animated: false)
    }
}


