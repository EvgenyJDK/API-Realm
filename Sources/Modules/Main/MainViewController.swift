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
import Alamofire

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
    var modeState: ModeState = .online
    var needRemoveGiphy: [Giphy] = []
    var needUpdates = true
    var timer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "GIPHY"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateUI()
        observeInternetConnection()
        observeViewModel()
        observeNotifications()
        launchApp()
//        load(search: defaultSearch)
    }

    private func configurateUI() {
        collectionView.register(UINib(nibName: GiphyCell.classIdentifier, bundle: nil), forCellWithReuseIdentifier: String(describing: GiphyCell.self))
    }
    
    private func observeInternetConnection() {
        AppReachability.shared.isReachable.asDriver().filterNil().drive(onNext: { [weak self] connection in
            if connection { self?.modeState = .online }
            else { self?.modeState = .offline }
            self?.load(search: (self?.defaultSearch)!)
        }).disposed(by: disposeBag)
    }
    
    private func observeNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updatesLoaded), name: Notification.Name("UpdatesLoaded"), object: nil)
    }
    
    private func observeViewModel() {
        giphyListViewModel.successHandler = { [weak self] (giphyList) in
            self?.giphyList.value = giphyList
            self?.collectionView.reloadData()
            self?.checkForUpdates()
        }
        giphyListViewModel.errorHandler = { error in
            print("GiphyListViewModel errorHandler")
        }
    }

    private func launchApp() {
        if UserDefaults.standard.bool(forKey: Constatnts.UserDefaults.firstLaunch) {
            load(search: defaultSearch)
        } else {
            UserDefaults.standard.set(true, forKey: Constatnts.UserDefaults.firstLaunch)
            needUpdates = false
            load(search: Constatnts.API.defaultSearch)
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
    
    private func checkForUpdates() {
        guard needUpdates else { return }
        load(search: Constatnts.API.defaultSearch)
        needUpdates = false
    }

    @objc private func updatesLoaded() {
        needUpdates = false
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
    
    private func removeGiphy() {
        for giphy in needRemoveGiphy {
            giphyListViewModel.removeGiphy(giphy: giphy)
        }
        needRemoveGiphy.removeAll()
    }
    
    //MARK: - Actions
    @IBAction func addToDB(_ sender: Any) {
        giphyList.value.forEach { (giphy) in
            StoreService.shared.store(giphy: giphy)
        }
    }
    
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
    
    fileprivate func loadImage(model: Giphy, callback: @escaping (Giphy, Bool)->()) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (model.fileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        let request = Alamofire.download(model.preview!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, to: destination)
        request.response { [weak self] (response) in
            if response.error == nil, let giphyPath = response.destinationURL?.path {
                print("----- CELL LOAD IMAGE = \(giphyPath)")
                callback(model, true)
            }
        }
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

        guard !model.isLoaded else { return cell }
        DispatchQueue.main.async {
            self.loadImage(model: model, callback: { (model, state) in
                model.isLoaded = state
                StoreService.shared.updateStore(gihy: model)
                if let updateCell = collectionView.cellForItem(at: indexPath) as? GiphyCell {
                    if let data = try? Data(contentsOf: model.fileUrl) {
                        updateCell.gifImageView.image = UIImage.gif(data: data)
                    }
                }
            })
        }
        return cell
    }
}


// MARK: - UICollectionViewDatasource

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let model = modelFrom(indexPath: indexPath)
        
        let gifStoryboard = UIStoryboard.init(name: "Gif", bundle: nil)
        let gifViewController = gifStoryboard.instantiateViewController(withIdentifier: "GifViewController") as! GifViewController
        gifViewController.giphy = model
        navigationController?.pushViewController(gifViewController, animated: false)

    }

}

