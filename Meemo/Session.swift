//
//  Session.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/12/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import Foundation

class Session:NSObject{
    var author:String = ""
    var biography:String = ""
    var desc:String = ""
    var file:String = ""
    var readMore:String = ""
    var time:String = ""
    var title:String = ""
    var listen:Bool = false
    var fileData:Data!
}
