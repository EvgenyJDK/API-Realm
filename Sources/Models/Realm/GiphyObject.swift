//
//  GiphyObject.swift
//  AnimationApp
//
//  Created by Administrator on 29.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Realm
import RealmSwift

class GiphyObject: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var preview = ""
    @objc dynamic var original = ""
    @objc dynamic var large = ""
    @objc dynamic var isLoaded = false

    override static func primaryKey() -> String? {
        return "id"
    }
    
    func fillFrom(giphy: Giphy) {
        id = giphy.id
        if let giphyPreview = giphy.preview { preview = giphyPreview }
        if let giphyOriginal = giphy.original { original = giphyOriginal }
        if let giphyLarge = giphy.large { large = giphyLarge }
        isLoaded = giphy.isLoaded
    }
}
