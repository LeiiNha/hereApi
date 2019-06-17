//
//  FavoritesManagerTests.swift
//  hereApiTests
//
//  Created by Erica Geralde on 17/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import XCTest
@testable import hereApi

class FavoritesManagerTests: XCTestCase {

    var location1 = Location(position: [231.0: 532.0], address: Address(text: "loc1", street: "loc1", postalCode: "loc1", district: "loc1", city: "loc1", county: "loc1", country: "loc1", countryCode: "loc1"))
    var location2 = Location(position: [232.0: 532.0], address: Address(text: "loc2", street: "loc2", postalCode: "loc2", district: "loc2", city: "loc2", county: "loc2", country: "loc2", countryCode: "loc2"))
     var location3 = Location(position: [233.0: 532.0], address: Address(text: "locOther", street: "locOther", postalCode: "locOther", district: "locOther", city: "locOther", county: "locOther", country: "locOther", countryCode: "locOther"))
     var location4 = Location(position: [234.0: 532.0], address: Address(text: "locOther", street: "locOther", postalCode: "locOther", district: "locOther", city: "locOther", county: "locOther", country: "locOther", countryCode: "locOther"))
     var location5 = Location(position: [235.0: 532.0], address: Address(text: "locOther", street: "locOther", postalCode: "locOther", district: "locOther", city: "locOther", county: "locOther", country: "locOther", countryCode: "locOther"))
     var location6 = Location(position: [236.0: 532.0], address: Address(text: "locOther", street: "locOther", postalCode: "locOther", district: "locOther", city: "locOther", county: "locOther", country: "locOther", countryCode: "locOther"))
     var location7 = Location(position: [237.0: 532.0], address: Address(text: "locOther", street: "locOther", postalCode: "locOther", district: "locOther", city: "locOther", county: "locOther", country: "locOther", countryCode: "locOther"))
     var location8 = Location(position: [238.0: 532.0], address: Address(text: "locOther", street: "locOther", postalCode: "locOther", district: "locOther", city: "locOther", county: "locOther", country: "locOther", countryCode: "locOther"))
    var location9 = Location(position: [239.0: 532.0], address: Address(text: "locOther", street: "locOther", postalCode: "locOther", district: "locOther", city: "locOther", county: "locOther", country: "locOther", countryCode: "locOther"))
    var location10 = Location(position: [2310.0: 532.0], address: Address(text: "locOther", street: "locOther", postalCode: "locOther", district: "locOther", city: "locOther", county: "locOther", country: "locOther", countryCode: "locOther"))


    override func tearDown() {
        FavoritesManager.clearFavorites()
    }
    func testIfIsFavoriteTrue() {
        FavoritesManager.saveFavorite(location: location1)
        XCTAssertTrue(FavoritesManager.checkIsFavorite(location1))
    }

    func testIfIsFavoriteFalse() {
        XCTAssertFalse(FavoritesManager.checkIsFavorite(location1))
    }

    func testFavoriteRemoved() {
        FavoritesManager.saveFavorite(location: location1)
        XCTAssertTrue(FavoritesManager.checkIsFavorite(location1))
        FavoritesManager.removeFavorite(location1)
        XCTAssertFalse(FavoritesManager.checkIsFavorite(location1))
    }

    func testFavoriteAdded() {
        FavoritesManager.saveFavorite(location: location1)
        XCTAssertTrue(FavoritesManager.checkIsFavorite(location1))
    }

    func testIfFavoritesFull() {
        FavoritesManager.saveFavorite(location: location1)
        FavoritesManager.saveFavorite(location: location2)
        FavoritesManager.saveFavorite(location: location3)
        FavoritesManager.saveFavorite(location: location4)
        FavoritesManager.saveFavorite(location: location5)
        FavoritesManager.saveFavorite(location: location6)
        FavoritesManager.saveFavorite(location: location7)
        FavoritesManager.saveFavorite(location: location8)
        FavoritesManager.saveFavorite(location: location9)
        FavoritesManager.saveFavorite(location: location10)
        XCTAssertTrue(FavoritesManager.checkFavoritesIsFull())
    }

    func testGetFavorites() {
        FavoritesManager.saveFavorite(location: location1)
        XCTAssert((FavoritesManager.loadFavorites()?.count).orDefault(0) > 0, "error in loading favorites!")
    }

    func testFavoritesCleared() {
        FavoritesManager.saveFavorite(location: location1)
        FavoritesManager.clearFavorites()
        XCTAssert(FavoritesManager.loadFavorites() == nil, "Error in clearing favorites!")
    }
}
