//
//  Location.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct Location: Codable {
    let position: Dictionary<Double, Double>
    let address: Address

}

struct LocationResponse: Codable {
    let location: Location
}

func ==(lhs: Location, rhs: Location) -> Bool {
    guard let lhsPosition = lhs.position.first, let rhsPosition = rhs.position.first else { return false }
    return lhsPosition.key == rhsPosition.key &&
            lhsPosition.value == rhsPosition.value
}
