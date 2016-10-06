//
//  Content.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/6/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import Foundation

class Content:NSObject{
    
    let urlKey = "url"
    let quoteKey = "quote"
    let authorKey = "author"
    let jobKey = "job"
    let durationKey = "duration"
    
    var quote:String!
    var author:String!
    var job:String!
    var url:String!
    var file:Data!
    var duration:Int!
    
    var dataFields: Set<String>!

    override init(){
        super.init()
        dataFields = [urlKey, quoteKey, authorKey, jobKey, durationKey]
    }
    
    func updateAttribute(key: String, value: String){
        switch key{
        case urlKey:
            updateUrl(value: value)
            break
        case quoteKey:
            updateQuote(value: value)
            break
        case authorKey:
            updateAuthor(value: value)
            break
        case jobKey:
            updateJob(value: value)
            break
        case durationKey:
            updateDuration(value: value)
            break
        default:
            break
        }
    }
    
    
    func updateUrl(value: String){
        self.url = value
    }
    
    func updateQuote(value: String){
        self.quote = value
    }
    func updateAuthor(value: String){
        self.author = value
    }
    func updateJob(value: String){
        self.job = value
    }
    func updateDuration(value: String){
        self.duration = Int(value)
    }
    
    
    
    
}
