//
//  JSONHelpers.swift
//  Tiles
//
//  Created by Zeeshan Tufail on 11/4/20.
//  Copyright © 2020 Zeeshan Tufail. All rights reserved.
//

import Foundation

class JSONHelpers {
    static func fromJSON<T:Codable>(json: String) -> T? {
        guard let data = json.data(using: .utf8, allowLossyConversion: false) else { return nil }
        // Decode
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode(T.self, from: data)
    }
    
    static func fromJSONArray<T:Codable>(json: String) -> [T]? {
        guard let data = json.data(using: .utf8, allowLossyConversion: false) else { return nil }
        // Decode
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode([T].self, from: data)
    }
    
    static func toJSON<T: Codable>(obj: T) -> String? {
        let jsonEncoder = JSONEncoder()
        
        guard let jsonData = try? jsonEncoder.encode(obj) else {return nil}
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        return json
    }
}
