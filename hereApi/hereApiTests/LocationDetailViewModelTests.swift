//
//  LocationDetailViewModelTests.swift
//  hereApiTests
//
//  Created by Erica Geraldes on 17/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

// swiftlint:disable line_length
import XCTest
import NMAKit
@testable import hereApi

class LocationDetailViewModelTests: XCTestCase {

    struct LocationManagerMock: LocationManagerProtocol {
        func getGeoCoordinatesFor(latitude: Double, longitude: Double) -> NMAGeoCoordinates {
            return NMAGeoCoordinates(latitude: 0.1, longitude: 2.0)
        }

        func getMarkerFor(latitude: Double?, longitude: Double?) -> NMAMapMarker? {
            return nil
        }

        func getCurrentLatitude() -> Double? {
            return 23.0
        }

        func getCurrentLongitude() -> Double? {
            return 24.0
        }

        func calculateDistanceTo(latitude: Double, longitude: Double) -> String? {
            return "teste"
        }
    }

    struct FavoritesManagerMock: FavoritesManagerProtocol {
        func loadFavorites() -> [Location]? {
            let location1 = Location(position: [231.0: 532.0], address: Address(text: "loc1", street: "loc1", postalCode: "loc1", district: "loc1", city: "loc1", county: "loc1", country: "loc1", countryCode: "loc1"))
            let location2 = Location(position: [232.0: 532.0], address: Address(text: "loc2", street: "loc2", postalCode: "loc2", district: "loc2", city: "loc2", county: "loc2", country: "loc2", countryCode: "loc2"))
            return [location1, location2]
        }

        func saveFavorite(location: Location) {
            return
        }

        func removeFavorite(_ location: Location) {
            return
        }

        func checkIsFavorite(_ location: Location) -> Bool {
            return true
        }

        func checkFavoritesIsFull() -> Bool {
            return false
        }

        func clearFavorites() {
            return
        }
    }

    func testCalculateDistance() {
        let viewModel = LocationDetailViewModel(url: "teste", location: Location(position: [233.0: 532.0], address: Address(text: "loc2", street: "loc3", postalCode: "loc2", district: "loc2", city: "loc2", county: "loc2", country: "loc2", countryCode: "loc2")), favoritesManager: FavoritesManagerMock(), locationManager: LocationManagerMock())

        XCTAssertEqual(viewModel.calculateDistanceToLocation(), "teste")
    }

    func testGetGeoCoords() {
        let viewModel = LocationDetailViewModel(url: "teste", location: Location(position: [233.0: 532.0], address: Address(text: "loc2", street: "loc3", postalCode: "loc2", district: "loc2", city: "loc2", county: "loc2", country: "loc2", countryCode: "loc2")), favoritesManager: FavoritesManagerMock(), locationManager: LocationManagerMock())

        let resultViewModel = viewModel.getGeoCoordinatesForLocation()
        let coords = NMAGeoCoordinates(latitude: 0.1, longitude: 2.0)
        XCTAssertEqual(resultViewModel?.latitude, coords.latitude)
        XCTAssertEqual(resultViewModel?.longitude, coords.longitude)
    }

    func testGetAddress() {
        let viewModel = LocationDetailViewModel(url: "teste", location: Location(position: [233.0: 532.0], address: Address(text: "loc2", street: "loc3", postalCode: "loc2", district: "loc2", city: "loc2", county: "loc2", country: "loc2", countryCode: "loc2")), favoritesManager: FavoritesManagerMock(), locationManager: LocationManagerMock())
        XCTAssertEqual(viewModel.getAddress(), "Street: loc3\nPostal Code: loc2\nLatitude: 233.0, Longitude: 532.0\n")
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
