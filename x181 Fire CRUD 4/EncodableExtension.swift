//
//  EncodableExtension.swift
//  x181 Fire CRUD 4
//
//  Created by Peter Forward on 5/8/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation

enum MyError: Error {
    case encodingError
}

extension Encodable {
    
    func toJson(excluding keys: [String] = [String]()) throws -> [String: Any] {
        
        let objectData = try JSONEncoder().encode(self)
        let jsonOnbject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonOnbject as? [String: Any] else {
            throw MyError.encodingError
        }
        
        for key in keys {
            json[key] = nil
        }
        
        return json
    }
    
}
