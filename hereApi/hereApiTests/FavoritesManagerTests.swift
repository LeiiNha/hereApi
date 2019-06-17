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

    var favoritesManager: FavoritesManager!

    override func setUp() {
        self.favoritesManager = FavoritesManager()
    }
    override func tearDown() {
        self.favoritesManager.clearFavorites()
        self.favoritesManager = nil
    }
    func testIfIsFavoriteTrue() {
        self.favoritesManager.saveFavorite(location: location1)
        XCTAssertTrue(self.favoritesManager.checkIsFavorite(location1))
    }

    func testIfIsFavoriteFalse() {
        XCTAssertFalse(self.favoritesManager.checkIsFavorite(location1))
    }

    func testFavoriteRemoved() {
        self.favoritesManager.saveFavorite(location: location1)
        XCTAssertTrue(self.favoritesManager.checkIsFavorite(location1))
        self.favoritesManager.removeFavorite(location1)
        XCTAssertFalse(self.favoritesManager.checkIsFavorite(location1))
    }

    func testFavoriteAdded() {
        self.favoritesManager.saveFavorite(location: location1)
        XCTAssertTrue(self.favoritesManager.checkIsFavorite(location1))
    }

    func testIfFavoritesFull() {
        self.favoritesManager.saveFavorite(location: location1)
        self.favoritesManager.saveFavorite(location: location2)
        self.favoritesManager.saveFavorite(location: location3)
        self.favoritesManager.saveFavorite(location: location4)
        self.favoritesManager.saveFavorite(location: location5)
        self.favoritesManager.saveFavorite(location: location6)
        self.favoritesManager.saveFavorite(location: location7)
        self.favoritesManager.saveFavorite(location: location8)
        self.favoritesManager.saveFavorite(location: location9)
        self.favoritesManager.saveFavorite(location: location10)
        XCTAssertTrue(self.favoritesManager.checkFavoritesIsFull())
    }

    func testGetFavorites() {
        self.favoritesManager.saveFavorite(location: location1)
        XCTAssert((self.favoritesManager.loadFavorites()?.count).orDefault(0) > 0, "error in loading favorites!")
    }

    func testFavoritesCleared() {
        self.favoritesManager.saveFavorite(location: location1)
        self.favoritesManager.clearFavorites()
        XCTAssert(self.favoritesManager.loadFavorites() == nil, "Error in clearing favorites!")
    }
}
