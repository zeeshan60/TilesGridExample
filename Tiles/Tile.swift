//
//  Tile.swift
//  Tiles
//
//  Created by Zeeshan Tufail on 10/4/20.
//  Copyright © 2020 Zeeshan Tufail. All rights reserved.
//

import UIKit

class Tile: Codable {
    
    var Id : String
    var Label: String
    var Priority: Double
    
    init(id: String, label: String, priority: Double) {
        self.Id = id
        self.Label = label
        self.Priority = priority
    }
}
