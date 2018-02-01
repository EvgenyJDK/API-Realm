//
//  StoreService.swift
//  AnimationApp
//
//  Created by Administrator on 29.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import RealmSwift

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
    
    func updateStore(gihy: Giphy) {
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            try! realm.write {
                let model = realm.objects(GiphyObject.self).filter("id contains '\(gihy.id)'").first
                model?.isLoaded = gihy.isLoaded
            }
        }
    }
    
    func load() -> [Giphy] {
        let realm = try! Realm()
        var giphyList: [Giphy] = []
        let giphy = realm.objects(GiphyObject.self)
        giphy.forEach { (giphyObject) in
            if let giphy = Giphy.init(id: giphyObject.id, large: giphyObject.original, preview: giphyObject.preview) {
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
            }
        }
    }
}
