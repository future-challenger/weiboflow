//
//  BaseModel.swift
//  CollectionViewDemo
//
//  Created by Bruce Lee on 25/1/2016.
//  Copyright © 2016 Dynamic Cell. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseModel: Mappable {
    var previousCursor: Int?
    var nextCursor: Int?
    var hasVisible: Bool?
    var statuses: [StatusModel]?
    var totalNumber: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        previousCursor <- map["previous_cursor"]
        nextCursor <- map["next_cursor"]
        hasVisible <- map["hasvisible"]
        statuses <- map["statuses"]
        totalNumber <- map["total_number"]
    }
}
