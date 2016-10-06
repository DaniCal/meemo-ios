//
//  ContentManager.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/6/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import Foundation

@objc protocol ContentManagerDelegate{
    @objc optional func contentDidUpdate()
    @objc optional func fileDidUpdate()
    @objc optional func fileIsLoading()
    @objc optional func fileDidLoad()
}


class ContentManager: NSObject, FirebaseSynchornizeDelegate{
    
    let content:Content = Content()
    
    //FirebaseSynchornizeDelegate func (protocol definition in FirebaseSynchronizer.swift)
    func firebaseDataDidUpdate(key: String, value: String){
        content.updateAttribute(key: key, value: value)
    }
    
    func connectToDB(){
        FirebaseSynchronizer.initSubscription(dataFields: content.dataFields)
    }
    
    
}
