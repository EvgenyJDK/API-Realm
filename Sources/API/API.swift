//
//  API.swift
//  AnimationApp
//
//  Created by Administrator on 23.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum API {

    static func getList(search: String, handler:@escaping (GiphyList?) -> Void) {
        
        let request = Constatnts.API.url + search + Constatnts.API.apiKey
        print(request)
        Alamofire.request(request).responseJSON { (response) in
            if let json = response.result.value as? [String : Any] {
                if let list = Mapper<GiphyList>().map(JSON: json) {
                    handler(list)
                }
                handler(nil)
            }
        }
    }
}
