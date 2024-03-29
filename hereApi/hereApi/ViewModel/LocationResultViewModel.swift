//
//  LocationResultViewModel.swift
//  hereApi
//
//  Created by Erica Geraldes on 17/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit
import NMAKit

protocol LocationResultDelegate: class {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String, _ completion: @escaping () -> Void)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, viewController: UIViewController)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath, _ completion: @escaping () -> Void)
    func numberOfSections(in tableView: UITableView) -> Int
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}
final class LocationResultViewModel {
    private(set) var locationResults: [NMALink]?
    private(set) var lastResultPage: NMADiscoveryPage?
    let networkManager: NetworkManager
    let locationManager: LocationManagerProtocol
    let favoritesManager: FavoritesManagerProtocol

    init(locationManager: LocationManagerProtocol, favoritesManager: FavoritesManagerProtocol) {
        self.locationManager = locationManager
        self.favoritesManager = favoritesManager
        self.networkManager = NetworkManager()
    }

    private func getLocationDetails(url: String, _ completion: @escaping (Location) -> Void) {
        networkManager.getDetails(url: url, completion: { location, _ in
            guard let location = location else { return }
            completion(location)
        })
    }
}

extension LocationResultViewModel: LocationResultDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath, _ completion: @escaping () -> Void) {
        if let count = self.locationResults?.count, indexPath.row == count - 1 {
            lastResultPage?.nextPageRequest?.start(block: { _, data, error in
                guard error == nil, data is NMADiscoveryPage, let resultPage = data as? NMADiscoveryPage else {
                    print ("invalid type returned \(String(describing: data))")
                    return
                }
                self.locationResults?.append(contentsOf: resultPage.discoveryResults)
                self.lastResultPage = resultPage
                completion()
            })
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? LocationTableViewCell
                                                        else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.name = self.locationResults?[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.locationResults?.count).orDefault(0)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String, _ completion: @escaping () -> Void) {
        guard let latitude = self.locationManager.getCurrentLatitude(),
            let longitude = self.locationManager.getCurrentLongitude() else { return }
        let places = NMAPlaces.shared().makeSearchRequest(location: NMAGeoCoordinates(latitude: latitude,
                                                                                      longitude: longitude),
                                                                                    query: searchBar.text.orDefault(""))

        places?.start(block: { _, data, error in
            guard error == nil, data is NMADiscoveryPage, let resultPage = data as? NMADiscoveryPage else {
                print ("invalid type returned \(String(describing: data))")
                return
            }
            self.locationResults = resultPage.discoveryResults
            self.lastResultPage = resultPage
            completion()
        })
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, viewController: UIViewController) {
        guard let url = self.locationResults?[indexPath.row].url else { return }
        self.getLocationDetails(url: url, { location in
            let viewModel = LocationDetailViewModel(url: url,
                                                    location: location,
                                                    favoritesManager: self.favoritesManager,
                                                    locationManager: self.locationManager)
            let detailPage = LocationDetailViewController(viewModel: viewModel)
            DispatchQueue.main.async {
                viewController.navigationController?.pushViewController(detailPage, animated: true)
            }
        })
    }
}
