//
//  Location.swift
//  hereApi
//
//  Created by Erica Geraldes on 16/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import Foundation

struct Location {
    let coordinates: Coordinates?
    let address: Address?
    
    private enum CodingKeys: String,CodingKey {
        case coordinates = "position"
        case address
    }
}

extension Location: Decodable {
    init(decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coordinates = try values.decodeIfPresent(Coordinates.self, forKey: .coordinates)
        address = try values.decodeIfPresent(Address.self, forKey: .address)
    }
}
