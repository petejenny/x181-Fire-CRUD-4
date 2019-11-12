//
//  SnapshotExtension.swift
//  x181 Fire CRUD 4
//
//  Created by Peter Forward on 5/7/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
    
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T {

        var documentJson = data()
        if includingId {
            documentJson?["id"] = documentID
        }

        let documentData = try JSONSerialization.data(withJSONObject: documentJson!, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        
        return decodedObject
    }
    
}
