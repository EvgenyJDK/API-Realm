//
//  Giphy.swift
//  AnimationApp
//
//  Created by Administrator on 27.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

class Giphy: Mappable, Model {
    
    var id : String?
    var original: String?
    var preview: String?
    
//    var json: JSON {
//        return JSON.init(["id" : id,
//                          "original" : original,
//                          "preview" : preview])
//    }
    
    required init?(map: Map) {
    }

    required init?(id: String, original: String, preview: String) {
        self.id = id
        self.original = original
        self.preview = preview
    }
    
    required init(json: JSON) {

    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        original        <- map["images.original_still.url"]
        preview         <- map["images.preview_gif.url"]      
    }
}
