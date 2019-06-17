//
//  Coordinates.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct Coordinates {
    let latitude: Float?
    let longitude: Float?
    
    private enum CodingKeys: String,CodingKey {
        case latitude
        case longitude
    }
}

extension Coordinates: Decodable {
    init(decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decodeIfPresent(Float.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Float.self, forKey: .longitude)
    }
}
