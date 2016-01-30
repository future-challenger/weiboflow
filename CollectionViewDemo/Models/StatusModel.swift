//
//  StatusModel.swift
//  CollectionViewDemo
//
//  Created by Bruce Lee on 25/1/2016.
//  Copyright © 2016 Dynamic Cell. All rights reserved.
//

import UIKit
import ObjectMapper

class StatusModel: BaseModel {
    var statusId: String?
    var thumbnailPic: String?
    var bmiddlePic: String?
    var originalPic: String?
    var weiboText: String?
    var user: WBUserModel?

    required init?(_ map: Map) {
        super.init(map)
        
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        statusId <- map["id"]
        thumbnailPic <- map["thumbnail_pic"]
        bmiddlePic <- map["bmiddle_pic"]
        originalPic <- map["original_pic"]
        weiboText <- map["text"]
    }
}
