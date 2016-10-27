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
    @objc optional func firebaseDidRevceiveJourney(journeyContent: [Content])

}


class FirebaseSynchronizer: NSObject{
    static var delegate:FirebaseSynchornizeDelegate?
    static let rootRef = FIRDatabase.database().reference()

    static let journeyKey: String = "journey"
    static let titleKey: String = "title"
    static let authorKey: String = "author"
    static let portraitKey: String = "portrait"
    static let lengthKey: String = "length"
    static let urlKey: String = "url"
    static let messageKey: String = "message"
    static let buttonKey: String = "button"
    static let enabledKey: String = "enabled"





    
    
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
    
    static func subscribeToJourney(){
        let conditionRef = rootRef.child(self.journeyKey)
        conditionRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            
            var journeyContent: [Content] = []
            for index in 1...7 {
                let newContent = Content()
                let dayKey:String = "day"
                let title = (snapshot.childSnapshot(forPath: dayKey + String(index) + "/" + titleKey).value as? String)!;
                newContent.updateQuote(value: title)
                let author = (snapshot.childSnapshot(forPath: dayKey + String(index) + "/" + authorKey).value as? String)!;
                newContent.updateAuthor(value: author)
                let length = (snapshot.childSnapshot(forPath: dayKey + String(index) + "/" + lengthKey).value as? String)!;
                newContent.updateDuration(value: length)
                let portrait = (snapshot.childSnapshot(forPath: dayKey + String(index) + "/" + portraitKey).value as? String)!;
                newContent.updatePortrait(value: portrait)
                let url = (snapshot.childSnapshot(forPath: dayKey + String(index) + "/" + urlKey).value as? String)!;
                newContent.updateUrl(value: url)
                let message = (snapshot.childSnapshot(forPath: dayKey + String(index) + "/" + messageKey).value as? String)!;
                newContent.updateMessage(value: message)
                let button = (snapshot.childSnapshot(forPath: dayKey + String(index) + "/" + buttonKey).value as? String)!;
                newContent.updateButton(value: button)
                let enabled = (snapshot.childSnapshot(forPath: dayKey + String(index) + "/" + enabledKey).value as? Bool)!;
                if(!enabled){
                    newContent.disable()
                }

                journeyContent.append(newContent)
            }
            
            self.delegate?.firebaseDidRevceiveJourney!(journeyContent: journeyContent)
           
            
        })
    }
    
}
