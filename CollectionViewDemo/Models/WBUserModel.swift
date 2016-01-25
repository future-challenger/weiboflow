//
//  WeiboUserModel.swift
//  CollectionViewDemo
//
//  Created by Bruce Lee on 25/1/2016.
//  Copyright © 2016 Dynamic Cell. All rights reserved.
//

import UIKit
import ObjectMapper

class WBUserModel: BaseModel {
    
    var weiboUserId: String?
    var screenName: String?
    var location: String?
    var description: String?
    
    required init?(_ map: Map) {
        super.init(map)
        
    }
    
    override func mapping(map: Map) {
        weiboUserId <- map["id"]
        screenName <- map["screen_name"]
        location <- map["screen_name"]
        description <- map["description"]
    }
}
