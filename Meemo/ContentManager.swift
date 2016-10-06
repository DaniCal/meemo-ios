//
//  ContentManager.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/6/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import Foundation
import Alamofire


@objc protocol ContentManagerDelegate{
    @objc optional func contentDidUpdate()
    @objc optional func fileDidUpdate()
    @objc optional func fileDidLoad()
}


class ContentManager: NSObject, FirebaseSynchornizeDelegate{
    
    let content:Content = Content()
    var delegate:ContentManagerDelegate?
    
    //FirebaseSynchornizeDelegate func (protocol definition in FirebaseSynchronizer.swift)
    func firebaseDataDidUpdate(key: String, value: String){
        content.updateAttribute(key: key, value: value)
        delegate?.contentDidUpdate!()
        if(key == content.urlKey){
            self.delegate?.fileDidUpdate!()
        }
    }
    
    func connectToDB(){
        FirebaseSynchronizer.initSubscription(dataFields: content.dataFields)
    }
    
    func quote() -> String{
        return content.quote
    }
    
    func author() -> String{
        return content.author
    }
    
    func job() -> String{
        return content.job
    }
    
    func file() -> Data{
        return content.file
    }
    
    func duration() -> Int{
        return content.duration
    }
    
    func downloadFile(){
        
        Alamofire.request(content.url).response { response in
            debugPrint(response)
            if let data = response.data {
                self.content.file = data
                self.delegate?.fileDidLoad!()
            }else{
                //TODO error handling hhtp request
            }
        }
    }
    
    
}
