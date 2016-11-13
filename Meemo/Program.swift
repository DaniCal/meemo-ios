//
//  Program.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/12/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import Foundation

class Program:NSObject{
    
    var title:String = ""
    var teaser:String = ""
    var subtitle:String = ""
    var sessions:[Session] = []
    var descr:String = ""
    var pictureSquare:String = ""
    var pictureSquareData:Data!
    var pictureOverview:String = ""
    var PictureOverviewData:Data!
    var picturePlayer:String = ""
    var picturePlayerData:Data!
}
