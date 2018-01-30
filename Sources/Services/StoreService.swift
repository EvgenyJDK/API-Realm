//
//  StoreService.swift
//  AnimationApp
//
//  Created by Administrator on 29.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import RealmSwift
import  SwiftyJSON

class StoreService {
    static let shared = StoreService()

    func store(giphy: Giphy) {
        DispatchQueue(label: "background").async {
            let giphyObject = GiphyObject()
            giphyObject.fillFrom(giphy: giphy)
            let realm = try! Realm()
            try! realm.write {
                realm.add(giphyObject, update: true)
            }
        }
    }
    
    func load() -> [Giphy] {
        let realm = try! Realm()
//        let giphy: [Giphy] = realm.objects(GiphyObject.self).reversed().map({
//            let giphy = Giphy.init(json: $0.json)
//            return giphy
//        })
        var giphyList: [Giphy] = []
        let giphy = realm.objects(GiphyObject.self)
        giphy.forEach { (giphyObject) in
            if let giphy = Giphy.init(id: giphyObject.id, original: giphyObject.original, preview: giphyObject.preview) {
                giphyList.append(giphy)
            }
        }
        return giphyList
    }
    
    
    func remove() {
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(realm.objects(GiphyObject.self))
//                let giphyRealm = realm.objects(GiphyObject.self).filter("id contains '\(giphy.id)'")
//                if giphyRealm.count != 0 {
//                    realm.delete(giphyRealm)
//                }
            }
        }
    }
    
}
