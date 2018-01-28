//
//  API.swift
//  AnimationApp
//
//  Created by Administrator on 23.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum API {

    private static let url = "http://api.giphy.com/v1/gifs/search?q="
    static func headers() -> HTTPHeaders {
        return [:]
    }
    
    static func getRequest(with path: String, parameters: [String : Any]) -> DataRequest {
        print("API GET = \(API.url + path + "&api_key=AWKqC7bHY2fkSNpeu4T6Fr8SGFFRZYrh")")
        print("PARAMETERS = \(parameters)")
        return Alamofire.request(API.url + path,
                                 method: .get,
                                 parameters: parameters,
                                 encoding: JSONEncoding.default,
                                 headers: API.headers())
    }
    
    static func validate(response: DataResponse<Any>, handler: @escaping ((SwiftyJSON.JSON?, NSError?) -> Void)) {
        if let error = response.result.error {
            handler(nil, error as NSError)
        } else if let value = response.result.value {
            let json = JSON(value)
            handler(json, nil)
        }
    }
}
