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
    
    func myCreate<T: Codable>(for encodableObject: T, in collectionReference: MyFireCollectionRef) {
        do {
            let json = try encodableObject.toJson(excluding: ["id"])
            reference(to: collectionReference).addDocument(data: json)
        } catch {
            print(error)
        }
        
        
    }
    
    func read() {
        
        reference(to: .users).addSnapshotListener { (snapshot, _) in
            
            guard let snapshot = snapshot else {return}
            for document in snapshot.documents {
                print(document.data())
            }
        }
    }
    
    
    func myRead<T: Decodable>(from collectionReference: MyFireCollectionRef, returning objectType: T.Type, completion: @escaping ([T]) -> Void) {
        
        reference(to: collectionReference).addSnapshotListener { (snapshot, _) in
            
            guard let snapshot = snapshot else {return}
            
            do {
                
                var objects = [T]()
                for document in snapshot.documents {
                    let object = try document.decode(as: objectType.self)
                    objects.append(object)
                }
                
                completion(objects)
                
            } catch {
                print(error)
            }
        }
    }
    
    func update() {
        
        reference(to: .users).document("aDeXNsNXlbsEb4Uh9yaX").setData(["age": 75, "name": "Wally"])
        
    }
    
    func myUpdate<T: Encodable & IdentifiableFirestoreDocId>(for encodableObject: T, in collectionReference: MyFireCollectionRef) {
        do {
            
            let json = try encodableObject.toJson(excluding: ["id"])
            guard let id = encodableObject.id else {
                throw MyError.encodingError
            }
            reference(to: collectionReference).document(id).setData(json)
            
        } catch {
            print(error)
        }
    }
    
    func delete() {
        
        let userReference = Firestore.firestore().collection("users")
        userReference.document("aDeXNsNXlbsEb4Uh9yaX").delete()
        
    }
    
    func myDelete<T: IdentifiableFirestoreDocId>(_ identifiableObject: T, in collectionReference: MyFireCollectionRef) {
        do {
            guard let id = identifiableObject.id else {throw MyError.encodingError}
            
            reference(to: collectionReference).document(id).delete()
        } catch {
            print(error)
        }
    }
    
}
