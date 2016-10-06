//
//  ContentManager.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/6/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import Foundation

class ContentManager: NSObject, FirebaseSynchornizeDelegate{
    
    let dataFields: Set<String> = ["url", "quote", "author", "job", "duration"]
    
    //FirebaseSynchornizeDelegate func (protocol definition in FirebaseSynchronizer.swift)
    func firebaseDataDidUpdate(key: String, value: String){
        
    }
    
    func connectToDB(){
        FirebaseSynchronizer.initSubscription(dataFields: dataFields)
    }
    
    
}
