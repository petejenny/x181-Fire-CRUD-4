//
//  Users.swift
//  x181 Fire CRUD 4
//
//  Created by Peter Forward on 5/6/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation

protocol IdentifiableFirestoreDocId {
    var id: String? {get set}
}

// User object
struct User: Codable, IdentifiableFirestoreDocId {
    var id: String? = nil // default value nil
    let name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
