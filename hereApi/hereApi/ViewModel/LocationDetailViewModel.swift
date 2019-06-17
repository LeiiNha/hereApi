//
//  LocationDetailViewModel.swift
//  hereApi
//
//  Created by Erica Geraldes on 17/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import UIKit
import NMAKit

protocol LocationDetailDelegate {
    func handleBtnPress(_ sender: UIButton)
}
final class LocationDetailViewModel {
    let url: String
    let location: Location
    let favoritesManager: FavoritesManagerProtocol
    let locationManager: LocationManagerProtocol
    
    private(set) var favoriteLocations: [Location]?
    
    init(url: String, location: Location, favoritesManager: FavoritesManagerProtocol, locationManager: LocationManagerProtocol) {
        self.url = url
        self.location = location
        self.favoritesManager = favoritesManager
        self.locationManager = locationManager
        self.favoriteLocations = self.favoritesManager.loadFavorites()
        
    }
    
}

extension LocationDetailViewModel {
    func getGeoCoordinatesForLocation() -> NMAGeoCoordinates? {
        guard let latitude = self.location.position.first?.key, let longitude = self.location.position.first?.value else { return nil }
        return self.locationManager.getGeoCoordinatesFor(latitude: latitude, longitude: longitude)
    }
    func getMarkerForLocation() -> NMAMapMarker? {
       guard let latitude = self.location.position.first?.key, let longitude = self.location.position.first?.value else { return nil }
        return self.locationManager.getMarkerFor(latitude: latitude, longitude: longitude)
    }
    
    func getAddress() -> String {
        
        return String(format: "Street: %@\nPostal Code: %@\nLatitude: %@, Longitude: %@\n", self.location.address.street.orDefault(""), self.location.address.postalCode.orDefault(""), (self.location.position.first?.key.description).orDefault(""), (self.location.position.first?.value.description).orDefault(""))
    }
    
    func getImageForLocation() -> UIImage? {
        if self.favoritesManager.checkIsFavorite(self.location) {
            return Images.likeFilled
        }
        return Images.like
    }
    
    func calculateDistanceToLocation() -> String? {
        guard let latitude = self.location.position.first?.key, let longitude = self.location.position.first?.value else { return nil }
        return self.locationManager.calculateDistanceTo(latitude: latitude, longitude: longitude)
    }
}

extension LocationDetailViewModel: LocationDetailDelegate {
    func handleBtnPress(_ sender: UIButton) {
        if sender.currentImage == Images.like {
            self.favoritesManager.saveFavorite(location: self.location)
        } else {
            self.favoritesManager.removeFavorite(self.location)
        }
    }
}
