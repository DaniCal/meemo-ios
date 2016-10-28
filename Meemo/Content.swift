//
//  Content.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/6/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import Foundation

class Content:NSObject{
    
    let portraitKey = "portrait"
    let urlKey = "url"
    let quoteKey = "quote"
    let authorKey = "author"
    let durationKey = "duration"
    
    var enabled = true
    
    var quote:String!
    var author:String!
    var job:String!
    var url:String!
    var file:Data!
    var picture:Data!
    var duration:Int = 0
    var portrait:String!
    var message:String!
    var button:String!
    var link:String!
    var index:Int = 0
    
    var dataFields: Set<String>!

    override init(){
        super.init()
        dataFields = [urlKey, quoteKey, authorKey, durationKey, portraitKey]
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
        case durationKey:
            updateDuration(value: value)
            break
        case portraitKey:
            updatePortrait(value: value)
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
        self.duration = Int(value)!
    }
    
    func updatePortrait(value: String){
        self.portrait = value;
    }
    
    func updateMessage(value: String){
        self.message = value;
    }
    
    func updateButton(value: String){
        self.button = value;
    }
    
    func updateLink(value: String){
        self.link = value
    }
    
    func setIndex(value: Int){
        self.index = value
    }
    
    func disable(){
        enabled = false
    }
}
