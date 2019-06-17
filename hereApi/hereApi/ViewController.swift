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
    var mapView: NMAMapView?
    var resultsTableView: UITableView?
    var locationResults: [NMALink]?
    var favoriteLocations: [Location]?
    
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
        configureFavoritesTableView()
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
        
        self.mapView = NMAMapView(frame: CGRect(x: 0, y: Spacing.XL, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.view.safeAreaLayoutGuide.layoutFrame.height / 2))
        guard let mapView = self.mapView else { return }
        self.view.addSubview(mapView)
        guard let location = locationManager.location else { return }
        let coords: NMAGeoCoordinates = NMAGeoCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        mapView.set(geoCenter: coords, animation: .none)
        let marker = NMAMapMarker(geoCoordinates: coords)
        marker.icon = Images.pin
        mapView.add(marker)
        mapView.zoomLevel = Constants.mapZoomDefault
    }
    
    func configureFavoritesTableView() {
        self.favoriteLocations = FavoritesManager.loadFavorites()
        guard self.favoriteLocations != nil else { return }

        let favoritesTableView = UITableView(frame: CGRect.zero, style: .grouped)
        favoritesTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(favoritesTableView)
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        favoritesTableView.translatesAutoresizingMaskIntoConstraints = false
        favoritesTableView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        favoritesTableView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        favoritesTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
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

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let location = self.favoriteLocations?[indexPath.row].position.first,
            let mapView = self.mapView else { return }
        let coords: NMAGeoCoordinates = NMAGeoCoordinates(latitude: location.key, longitude: location.value)
        mapView.set(geoCenter: coords, animation: .none)
        let marker = NMAMapMarker(geoCoordinates: coords)
        marker.icon = Images.pin
        mapView.add(marker)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.favoriteLocations?.count).orDefault(0)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }

        cell.selectionStyle = .none
        cell.name = self.favoriteLocations?[indexPath.row].address.text?.replacingOccurrences(of: "<br/>", with: " ")

        return cell
    }


}
