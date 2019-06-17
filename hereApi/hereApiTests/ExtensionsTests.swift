//
//  ExtensionsTests.swift
//  hereApiTests
//
//  Created by Erica Geralde on 17/06/2019.
//  Copyright © 2019 Erica Geraldes. All rights reserved.
//

import XCTest
@testable import hereApi
class ExtensionsTests: XCTestCase {

    func testOrDefault() {
        let teste: String? = nil
        let teste2 = teste.orDefault("orDefault")
        XCTAssertTrue(teste2 == "orDefault")
    }

}
