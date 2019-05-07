//
//  MyFireService.swift
//  x181 Fire CRUD 4
//
//  Created by Peter Forward on 5/7/19.
//  Copyright © 2019 Peter Forward. All rights reserved.
//

import Foundation
import Firebase

class MyFireService {
    private init() {}
    static let shared = MyFireService()
    
    
    
    func configure() {
        FirebaseApp.configure()
    }
    
    private func reference(to myCollectionReference: MyFireCollectionRef) -> CollectionReference {
        return Firestore.firestore().collection(myCollectionReference.rawValue)
    }
    
    func create() {
        
        let userEntry: [String: Any] = ["name": "Joe",
                         "age": 52]
        
        
        //let userReference = Firestore.firestore().collection("users")
        
        reference(to: .users).addDocument(data: userEntry)
        
        
    }
    
    func read() {
        
        reference(to: .users).addSnapshotListener { (snapshot, _) in
            
            guard let snapshot = snapshot else {return}
            for document in snapshot.documents {
                print(document.data())
            }
            
        }
        
    }
    
    func update() {
        
        reference(to: .users).document("aDeXNsNXlbsEb4Uh9yaX").setData(["age": 75, "name": "Wally"])
        
    }
    
    func delete() {

        let userReference = Firestore.firestore().collection("users")
        
        userReference.document("aDeXNsNXlbsEb4Uh9yaX").delete()

        
    }
    
}
