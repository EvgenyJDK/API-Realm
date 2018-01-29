//
//  API.Giphy.swift
//  AnimationApp
//
//  Created by Administrator on 23.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import ObjectMapper

extension API {
    static func getGiphyList(searchText: String, handler:@escaping (JSON?, NSError?)-> Void) {

        let request = API.getRequest(with: searchText, parameters: ["": ""])
        request.responseJSON { (response) in

            API.validate(response: response, handler: handler)
        }
    }
    
    
    static func getList(search: String, handler:@escaping (GiphyList?) -> Void) {
        
        let request = Constatnts.API.url + search + Constatnts.API.apiKey
        print(request)
        
        Alamofire.request(request).responseJSON { (response) in
            if let json = response.result.value as? [String : Any] {
                let meta = Mapper<Meta>().map(JSON: json)
                print(meta?.msg ?? "")
                
                if let list = Mapper<GiphyList>().map(JSON: json) {
                    handler(list)
                }
                handler(nil)
            }
        }
    }
}

