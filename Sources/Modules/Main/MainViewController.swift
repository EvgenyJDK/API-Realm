//
//  ViewController.swift
//  AnimationApp
//
//  Created by Administrator on 18.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxOptional

enum ModeState {
    case offline
    case online
}

class MainViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var aspectGifView: UIView!
    
    private let giphyListViewModel = GiphyListViewModel()
    private var giphyList: Variable<[Giphy]> = Variable([])
    let disposeBag = DisposeBag()
    let defaultSearch = ""
    var modeState: ModeState = .offline
    var timer: Timer?
    var needRemoveGiphy: [Giphy] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "GIPHY"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateUI()
        observeInternetConnection()
        observeViewModel()
        load(search: defaultSearch)
    }

    private func configurateUI() {
        collectionView.register(UINib(nibName: GiphyCell.classIdentifier, bundle: nil), forCellWithReuseIdentifier: String(describing: GiphyCell.self))
    }
    
    private func observeInternetConnection() {
        AppReachability.shared.isReachable.asDriver().filterNil().drive(onNext: { [weak self] connection in
            if connection { self?.modeState = .online }
            else { self?.modeState = .offline }
            self?.load(search: defaultSearch)
        }).disposed(by: disposeBag)
    }
    
    private func observeViewModel() {
        giphyListViewModel.successHandler = { [weak self] (giphyList) in
            self?.giphyList.value = giphyList
            self?.collectionView.reloadData()
        }
        giphyListViewModel.errorHandler = { error in
            print("GiphyListViewModel errorHandler")
        }
    }
    
    private func load(search: String) {
        switch modeState {
        case .online:
            if search == defaultSearch {
                giphyListViewModel.load(search: search, online: false)
            } else { giphyListViewModel.load(search: search, online: true) }
        default:
            giphyListViewModel.load(search: search, online: false)
        }
    }
    
// MARK: - SearchBar Delegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 0.7,
            target: self,
            selector: #selector(MainViewController.searchGiphy),
            userInfo: searchText,
            repeats: false)
    }
    
    @objc func searchGiphy(timer: Timer) {
        guard let search = timer.userInfo as? String else { return }
        if search == defaultSearch {
            needRemoveGiphy = giphyList.value
            removeGiphy()
        }
            load(search: search)
        }
    }
    
    private func removeGiphy() {
        for giphy in needRemoveGiphy {
            giphyListViewModel.removeGiphy(giphy: giphy)
        }
        needRemoveGiphy.removeAll()
    }

    
    //MARK: - Actions
    @IBAction func clearDB(_ sender: Any) {
        StoreService.shared.remove()
        needRemoveGiphy = giphyList.value
        removeGiphy()
    }
    
    
}

// MARK: - UICollectionViewDatasource

extension MainViewController: UICollectionViewDataSource {
    fileprivate func modelFrom(indexPath: IndexPath) -> Giphy {
        let index = indexPath.section * Constatnts.UI.countItemInSection + indexPath.row
        print("INDEX PATH SECTION = \(indexPath.section)")
        print("INDEX PATH ROW = \(indexPath.row)")
        print("INDEX = \(index)")
        return giphyList.value[index]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        print("ROUNDING NUMBER OF SECTIONS = \(giphyList.value.roundingCountSection(Constatnts.UI.countItemInSection))")
        return giphyList.value.roundingCountSection(Constatnts.UI.countItemInSection)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constatnts.UI.countItemInSection
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiphyCell.classIdentifier, for: indexPath) as! GiphyCell
        let model = modelFrom(indexPath: indexPath)
        cell.fillWith(model: model)
        
        return cell
    }
}


// MARK: - UICollectionViewDatasource

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let model = modelFrom(indexPath: indexPath)
//        show(model: model)
        
        let gifStoryboard = UIStoryboard.init(name: "Gif", bundle: nil)
        let gifViewController = gifStoryboard.instantiateViewController(withIdentifier: "GifViewController") as! GifViewController
        gifViewController.url = model.preview!
        gifViewController.giphy = model
        navigationController?.pushViewController(gifViewController, animated: false)

    }

}

