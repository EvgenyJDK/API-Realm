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
import SwiftyJSON

class GiphyListViewModel {
    
    var successHandler: (([Giphy]) -> Void) = {giphyList in }
    var errorHandler: ((NSError) -> Void) = {_ in }
    var giphyList: Variable<[Giphy]> = Variable([])
    weak var mainVC: MainViewController?
    
    init() {

    }
    
    func load(search: String, online: Bool) {
        if online { loadList(search: search) }
        else { loadListFromStore() }
//        loadGiphyList(searchText: "funny+cat")
//        loadList(search: "funny+cat")
    }
    
    private func loadGiphyList(searchText: String) {
        API.getGiphyList(searchText: searchText) { [weak self] (json, error) in
//            if let error = error {
//                self?.errorHandler(error)
//                return
//            }
//            if let res = json as? [String: Any] {
//                let giphyList = Mapper<GiphyList>().map(JSON: res)
//                print(giphyList?.giphy?.count ?? 0)
//
//                giphyList?.giphy?.forEach({ (giphy) in
//                    print(giphy.id ?? 0)
//                    print(giphy.original ?? "")
//                    print(giphy.preview ?? "")
//                    self?.giphyList.value.append(giphy)
//                })
//            }
        }
    }
    
    private func loadList(search: String) {
        API.getList(search: search) { [weak self] (giphyList) in
            if let list = giphyList {
                var giphyArr: [Giphy] = []
                list.giphy?.forEach({ (giphy) in
                    print(giphy.preview)
                    print(giphy.large)
                    StoreService.shared.store(giphy: giphy)
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
