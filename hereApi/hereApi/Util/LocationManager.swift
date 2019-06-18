//
//  LocationManager.swift
//  hereApi
//
//  Created by Erica Geraldes on 17/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import CoreLocation
import NMAKit

private let sharedLocationmanager = CLLocationManager()

protocol LocationManagerProtocol {
    func getCurrentLatitude() -> Double?
    func getCurrentLongitude() -> Double?
    func calculateDistanceTo(latitude: Double, longitude: Double) -> String?
    func getGeoCoordinatesFor(latitude: Double, longitude: Double) -> NMAGeoCoordinates
    func getMarkerFor(latitude: Double?, longitude: Double?) -> NMAMapMarker?
}

struct LocationManager: LocationManagerProtocol {

    func getGeoCoordinatesFor(latitude: Double, longitude: Double) -> NMAGeoCoordinates {
        return NMAGeoCoordinates(latitude: latitude, longitude: longitude)
    }

    func getMarkerFor(latitude: Double?, longitude: Double?) -> NMAMapMarker? {
        guard let latitude = latitude, let longitude = longitude else { return nil }
        let marker = NMAMapMarker(geoCoordinates: self.getGeoCoordinatesFor(latitude: latitude, longitude: longitude))
        marker.icon = Images.pin
        return marker
    }

    func getCurrentLatitude() -> Double? {
        return sharedLocationmanager.location?.coordinate.latitude
    }

    func getCurrentLongitude() -> Double? {
        return sharedLocationmanager.location?.coordinate.longitude
    }

    func calculateDistanceTo(latitude: Double, longitude: Double) -> String? {
        guard let currentPos = sharedLocationmanager.location else { return nil }
        return currentPos.distance(from: CLLocation(latitude: latitude, longitude: longitude)).description
    }
}
