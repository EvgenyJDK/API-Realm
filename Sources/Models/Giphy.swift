//
//  Giphy.swift
//  AnimationApp
//
//  Created by Administrator on 27.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import ObjectMapper

class Giphy: Mappable {
    
    var id : String?
    var original: String?
    var preview: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        original        <- map["images.original_still.url"]
        preview         <- map["images.preview_gif.url"]      
    }
}
