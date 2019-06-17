//
//  LocationManager.swift
//  hereApi
//
//  Created by Erica Geraldes on 17/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation
import CoreLocation
import NMAKit

private let sharedLocationmanager = CLLocationManager()

struct LocationManager {
    
    static func getCurrentLatitude() -> Double? {
        return sharedLocationmanager.location?.coordinate.latitude
    }
    
    static func getCurrentLongitude() -> Double? {
        return sharedLocationmanager.location?.coordinate.longitude
    }
    
    static func getGeoCoordinatesFor(latitude: Double, longitude: Double) -> NMAGeoCoordinates {
        return NMAGeoCoordinates(latitude: latitude, longitude: longitude)
    }
    
    static func getMarkerFor(latitude: Double?, longitude: Double?) -> NMAMapMarker? {
        guard let latitude = latitude, let longitude = longitude else { return nil }
        let marker = NMAMapMarker(geoCoordinates: self.getGeoCoordinatesFor(latitude: latitude, longitude: longitude))
        marker.icon = Images.pin
        return marker
    }
    
    static func calculateDistanceTo(latitude: Double, longitude: Double) -> String? {
        guard let currentPos = sharedLocationmanager.location else { return nil }
        return currentPos.distance(from: CLLocation(latitude: latitude, longitude: longitude)).description
    }
}
