//
//  ContentManager.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/6/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//  
//  The ContentManager synchronizes continiously the data with the Firebase
//  backend database and holds the content in an instance of Content

import Foundation
import Alamofire


@objc protocol ContentManagerDelegate{
    @objc optional func contentDidUpdate()
    @objc optional func fileDidUpdate()
    @objc optional func fileDidLoad()
    @objc optional func pictureDidLoad()
}


class ContentManager: NSObject, FirebaseSynchornizeDelegate{
    
    let content:Content = Content()
    var delegate:ContentManagerDelegate?
    
    override init(){
        super.init()
        FirebaseSynchronizer.delegate = self
    }
    
    //FirebaseSynchornizeDelegate func (protocol definition in FirebaseSynchronizer.swift)
    //This event fires as soon as data fields in the database have changed
    
    
}
