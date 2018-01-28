//
//  Meta.swift
//  AnimationApp
//
//  Created by Administrator on 27.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import  ObjectMapper

class Meta: Mappable {
    
    var msg: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        msg           <- map["meta.msg"]
    }
    
}
