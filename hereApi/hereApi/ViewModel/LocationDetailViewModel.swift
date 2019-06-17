//
//  LocationDetailViewModel.swift
//  hereApi
//
//  Created by Erica Geraldes on 17/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation
import NMAKit

protocol LocationDetailDelegate {
    func handleBtnPress(_ sender: UIButton)
}
final class LocationDetailViewModel {
    let url: String
    let networkManager: NetworkManager
    let location: Location
    
    private(set) var favoriteLocations: [Location]?
    
    init(url: String, location: Location, networkManager: NetworkManager) {
        self.url = url
        self.location = location
        self.networkManager = networkManager
        self.favoriteLocations = FavoritesManager.loadFavorites()
    }
    
}

extension LocationDetailViewModel {
    func getGeoCoordinatesForLocation() -> NMAGeoCoordinates? {
        guard let latitude = self.location.position.first?.key, let longitude = self.location.position.first?.value else { return nil }
        return LocationManager.getGeoCoordinatesFor(latitude: latitude, longitude: longitude)
    }
    func getMarkerForLocation() -> NMAMapMarker? {
       guard let latitude = self.location.position.first?.key, let longitude = self.location.position.first?.value else { return nil }
        return LocationManager.getMarkerFor(latitude: latitude, longitude: longitude)
    }
    
    func getAddress() -> String {
        
        return String(format: "Street: %@\nPostal Code: %@\nLatitude: %@, Longitude: %@\n", self.location.address.street.orDefault(""), self.location.address.postalCode.orDefault(""), (self.location.position.first?.key.description).orDefault(""), (self.location.position.first?.value.description).orDefault(""))
    }
    
    func getImageForLocation() -> UIImage? {
        if FavoritesManager.checkIsFavorite(self.location) {
            return Images.likeFilled
        }
        return Images.like
    }
    
    func calculateDistanceToLocation() -> String? {
        guard let latitude = self.location.position.first?.key, let longitude = self.location.position.first?.value else { return nil }
        return LocationManager.calculateDistanceTo(latitude: latitude, longitude: longitude)
    }
}

extension LocationDetailViewModel: LocationDetailDelegate {
    func handleBtnPress(_ sender: UIButton) {
        if sender.currentImage == Images.like {
            FavoritesManager.saveFavorite(location: self.location)
        } else {
            FavoritesManager.removeFavorite(self.location)
        }
    }
}
