//
//  Constants.swift
//  AnimationApp
//
//  Created by Administrator on 28.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation

enum Constatnts {
    
    enum API {
        static let url = "http://api.giphy.com/v1/gifs/search?q="
        static let apiKey = "&api_key=AWKqC7bHY2fkSNpeu4T6Fr8SGFFRZYrh"
        static let defaultSearch = "funny+cat"
    }
    
    enum UI {
        static let countItemInSection = 3
    }
    
    enum UserDefaults {
        static let firstLaunch = "firstLaunch"
    }
    
}
