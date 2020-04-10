//
//  TileCell.swift
//  Tiles
//
//  Created by Zeeshan Tufail on 10/4/20.
//  Copyright © 2020 Zeeshan Tufail. All rights reserved.
//

import UIKit

class TileCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTileLabel: UILabel!
    
    func reloadData(tile: Tile) {
        self.lblTileLabel.text = tile.Label
    }
}
