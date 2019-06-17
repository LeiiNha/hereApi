//
//  MainViewModel.swift
//  hereApi
//
//  Created by Erica Geraldes on 17/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation
import NMAKit

protocol MainViewModelDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar, viewController: UIViewController)
    func numberOfSections(in tableView: UITableView) -> Int
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    func getFavoriteLocMarkerAndPosition(index: Int) -> (NMAMapMarker,NMAGeoCoordinates)?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

final class MainViewModel {
    
    private(set) var mapView: NMAMapView?
    private(set) var favoritesTableView: UITableView?
    private(set) var resultsTableView: UITableView?
    private(set) var locationResults: [NMALink]?
    private(set) var favoriteLocations: [Location]?
    
    enum Constants {
        static let mapZoomDefault: Float = 13.2
    }
    init() {
        self.favoriteLocations = FavoritesManager.loadFavorites()
    }

    func getMarkerForCurrentPosition() -> NMAMapMarker? {
        return LocationManager.getMarkerFor(latitude: LocationManager.getCurrentLatitude(), longitude: LocationManager.getCurrentLongitude())
    }
    
    func getGeoCoordinatesForCurrentPos() -> NMAGeoCoordinates? {
        guard let latitude = LocationManager.getCurrentLatitude(), let longitude = LocationManager.getCurrentLongitude() else { return nil }
        return NMAGeoCoordinates(latitude: latitude, longitude: longitude)
    }
}

extension MainViewModel: MainViewModelDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar, viewController: UIViewController) {
        let resultsViewModel = LocationResultViewModel()
        let results = LocationResultsTableViewController(style: .grouped, viewModel: resultsViewModel)
        searchBar.resignFirstResponder()
        viewController.navigationController?.pushViewController(results, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func getFavoriteLocMarkerAndPosition(index: Int) -> (NMAMapMarker,NMAGeoCoordinates)? {
        guard let location = self.favoriteLocations?[index].position.first else { return nil }
        let coords: NMAGeoCoordinates = NMAGeoCoordinates(latitude: location.key, longitude: location.value)
        let marker = NMAMapMarker(geoCoordinates: coords)
        marker.icon = Images.pin
        return (marker,coords)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.favoriteLocations?.count).orDefault(0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.name = self.favoriteLocations?[indexPath.row].address.text?.replacingOccurrences(of: "<br/>", with: " ")
        
        return cell
    }
}
