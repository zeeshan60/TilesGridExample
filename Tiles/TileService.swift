//
//  TileService.swift
//  Tiles
//
//  Created by Zeeshan Tufail on 10/4/20.
//  Copyright © 2020 Zeeshan Tufail. All rights reserved.
//

import UIKit
import Alamofire

class TileService: NSObject {
    
    static let service : TileService = TileService()
    static let TILE_SERVICE_HOST = "http://localhost:9235"
    
    static let GET_TILES_PATH = "tiles"
    
    static let POST_TILE_SELECTION_PATH = "selection"
    static let QUERY_PARAM_TILE_SELECTION_ID = "id"
    
    func getAbsoluteURLString(path: String, queryItems: [URLQueryItem]?) -> String {
        let urlComps = NSURLComponents(string: TileService.TILE_SERVICE_HOST + "/" + path)!
        urlComps.queryItems = queryItems
        let url = urlComps.url!
        return url.absoluteString
    }
    
    func getPriorityOrderedTiles(callback: @escaping ([Tile]?, Error?) -> ()) {
        let url = self.getAbsoluteURLString(path: TileService.GET_TILES_PATH, queryItems:nil)
        AF.request(url, method: .get).responseString { (response: AFDataResponse<String>) in
            guard let items = response.value else {
                callback(nil, response.error)
                return
            }
            let tiles: [Tile] = JSONHelpers.fromJSONArray(json: items) ?? []
            
            //Assuming we only display labels with atleast one character
            let nonEmptyLabelTiles = tiles.filter { (tile: Tile) -> Bool in
                tile.Label.count > 0
            }
            let sortedTiles = nonEmptyLabelTiles.sorted(by: { $0.Priority > $1.Priority })
            DispatchQueue.main.async {
                callback(sortedTiles, nil)
            }
            
        }
    }
    
    func submitTileSelection(id: String, callback: @escaping (SubmitTileResponseModel?, Error?) -> ()) {
        let queryItems = [URLQueryItem(name: "id", value: id)]
        let url = self.getAbsoluteURLString(path: TileService.POST_TILE_SELECTION_PATH, queryItems: queryItems)
        AF.request(url, method: .post).responseString { (response:AFDataResponse<String>) in
            guard let messageString = response.value else {
                callback(nil, response.error)
                return
            }
            
            guard let tileResponse : SubmitTileResponseModel = JSONHelpers.fromJSON(json: messageString) else {
                callback(nil, nil);
                return
            }
            callback(tileResponse, nil);
            
        }
    }
}
