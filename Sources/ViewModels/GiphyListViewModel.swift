//
//  GiphyListViewModel.swift
//  AnimationApp
//
//  Created by Administrator on 23.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class GiphyListViewModel {
    
    var successHandler: (([Giphy]) -> Void) = {giphyList in }
    var errorHandler: ((NSError) -> Void) = {_ in }
    var giphyList: Variable<[Giphy]> = Variable([])
    
    init() {
    }
    
    func load(search: String, online: Bool) {
        if online { loadList(search: search) }
        else { loadListFromStore() }
    }

    private func loadList(search: String) {
        API.getList(search: search) { [weak self] (giphyList) in
            if let list = giphyList {
                var giphyArr: [Giphy] = []
                list.giphy?.forEach({ (giphy) in
                    if search == Constatnts.API.defaultSearch {
                        StoreService.shared.store(giphy: giphy)
                    }
                    giphyArr.append(giphy)
                })
                self?.giphyList.value = giphyArr
            }
            if search == Constatnts.API.defaultSearch {
                NotificationCenter.default.post(name: Notification.Name("UpdatesLoaded"), object: nil)
            }
            self?.successHandler(self?.giphyList.value ?? [])
        }
    }
    
    private func loadListFromStore() {
        giphyList.value = StoreService.shared.load()
        self.successHandler(self.giphyList.value)
    }
    
    func removeGiphy(giphy: Giphy) {
        for _ in giphyList.value {
            if let index = giphyList.value.index(where: { $0.id == giphy.id }) {
                giphyList.value.remove(at: index)
            }
            successHandler(giphyList.value)
        }
    } 
}
