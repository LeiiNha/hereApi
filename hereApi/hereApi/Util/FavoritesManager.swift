//
//  FavoritesManager.swift
//  hereApi
//
//  Created by Erica Geralde on 17/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

protocol FavoritesManagerProtocol {
    func loadFavorites() -> [Location]?
    func saveFavorite(location: Location)
    func removeFavorite(_ location: Location)
    func checkIsFavorite(_ location: Location) -> Bool
    func checkFavoritesIsFull() -> Bool
    func clearFavorites()
}

struct FavoritesManager: FavoritesManagerProtocol {
    private enum Constants {
        static let maximumFavorites = 10
        static let favoritesKey = "SavedFavorites"
    }
    
    func loadFavorites() -> [Location]? {
        if let savedFavorites = UserDefaults.standard.object(forKey: Constants.favoritesKey) as? Data {
            if let loadedFavorites = try? JSONDecoder().decode([Location].self, from: savedFavorites) {
                return loadedFavorites
            }
        }
        return nil
    }

    func saveFavorite(location: Location) {
        var loadedFavorites: [Location] = self.loadFavorites().orDefault([])
        guard !checkFavoritesIsFull(), !checkIsFavorite(location) else { return }
        loadedFavorites.append(location)
        if let encoded = try? JSONEncoder().encode(loadedFavorites) {
            UserDefaults.standard.set(encoded, forKey: Constants.favoritesKey)
        }
    }

    func removeFavorite(_ location: Location) {
        if var loadedFavorites = self.loadFavorites() {
            loadedFavorites.removeAll(where: { $0 == location })
            if let encoded = try? JSONEncoder().encode(loadedFavorites) {
                UserDefaults.standard.set(encoded, forKey: Constants.favoritesKey)
            }
        }
    }

    func checkIsFavorite(_ location: Location) -> Bool {
        if let favorites = self.loadFavorites(), favorites.contains(where: {$0 == location}) {
            return true
        }
        return false
    }

    func checkFavoritesIsFull() -> Bool {
        if let favorites = self.loadFavorites(), favorites.count >= Constants.maximumFavorites {
            return true
        }
        return false
    }

    func clearFavorites() {
        UserDefaults.standard.removeObject(forKey: Constants.favoritesKey)
    }
}
