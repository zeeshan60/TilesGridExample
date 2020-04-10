//
//  TilesTests.swift
//  TilesTests
//
//  Created by Zeeshan Tufail on 10/4/20.
//  Copyright © 2020 Zeeshan Tufail. All rights reserved.
//

import XCTest
@testable import Tiles

class TilesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        //Just for my own testing. Ideally there would be bunch of tests for TileService and basically everything else
        let tile: Tile = Tile(id: "123", label: "great label", priority: 0.0)
        let json = JSONHelpers.toJSON(obj: tile)
        XCTAssertNotNil(json)
        let tileFromJson : Tile = JSONHelpers.fromJSON(json: json!)!;
        print(tileFromJson)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
