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
    
    var id = ""
    var original: String?
    var preview: String?
    var large: String?
    var isLoaded = false
    
    var fileUrl: URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectorPath: String = paths[0]
        let giphyDirectoryPath = documentDirectorPath.appending("/giphy/")
//        var filePath = id.replacingOccurrences(of: " ", with: "")
        let filePath = giphyDirectoryPath.appending("/\(id).gif")
        let fileUrl = URL.init(fileURLWithPath: filePath)
        return fileUrl
    }
    
    
    
//    var json: JSON {
//        return JSON.init(["id" : id,
//                          "original" : original,
//                          "preview" : preview])
//    }
    
    required init?(map: Map) {
    }

    required init?(id: String, large: String, preview: String) {
        self.id = id
//        self.original = original
        self.preview = preview
        self.large = large
    }
    
    required init(json: JSON) {

    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        original        <- map["images.original_still.url"]
        preview         <- map["images.preview_gif.url"]
        large           <- map["images.downsized_large.url"]
    }
}
