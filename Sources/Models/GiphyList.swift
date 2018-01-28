//
//  GiphyList.swift
//  AnimationApp
//
//  Created by Administrator on 23.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import ObjectMapper

class GiphyList: Mappable {

    var giphy: [Giphy]?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        giphy           <- map["data"]
    }
    
}

