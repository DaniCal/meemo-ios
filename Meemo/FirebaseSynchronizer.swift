//
//  FirebaseSynchronizer.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/6/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import Foundation
import Firebase

@objc protocol FirebaseSynchornizeDelegate{
    @objc optional func firebaseDataDidUpdate(key: String, value: String)
}


class FirebaseSynchronizer: NSObject{
    static var delegate:FirebaseSynchornizeDelegate?
    static let rootRef = FIRDatabase.database().reference()

    override init(){
        super.init()
        
    }
    
    static func initSubscription(dataFields: Set<String>){
        for field in dataFields{
            subscribeToString(key: field)
        }
    }
    
    static func subscribeToString(key: String){
        let conditionRef = rootRef.child(key)
        conditionRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            let value:String = (snapshot.value as? String)!
            if(snapshot.value != nil){
                self.delegate?.firebaseDataDidUpdate!(key: key, value: value)
                
            }
        })

    }
    
}
