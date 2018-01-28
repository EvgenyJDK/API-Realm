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

class MainViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let giphyListViewModel = GiphyListViewModel()
    private var giphy: Variable<[Giphy]> = Variable([])
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "GIPHY"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateCollection()
        observeViewModel()
        load()
    }

    private func configurateCollection() {
        collectionView.register(UINib(nibName: GiphyCell.classIdentifier, bundle: nil), forCellWithReuseIdentifier: String(describing: GiphyCell.self))
    }
    
    private func observeViewModel() {
        giphyListViewModel.successHandler = { [weak self] (giphyList) in
            self?.giphy.value = giphyList
            self?.collectionView.reloadData()
        }
        giphyListViewModel.errorHandler = { error in
            print("GiphyListViewModel errorHandler")
        }
    }
    
    private func load() {
        giphyListViewModel.load()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
  
        }
    }

}

// MARK: - UICollectionViewDatasource

extension MainViewController: UICollectionViewDataSource {
    fileprivate func modelFrom(indexPath: IndexPath) -> Giphy {
        let index = indexPath.section * Constatnts.UI.countItemInSection + indexPath.row
        print("INDEX PATH SECTION = \(indexPath.section)")
        print("INDEX PATH ROW = \(indexPath.row)")
        print("INDEX = \(index)")
        return giphy.value[index]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        print("ROUNDING NUMBER OF SECTIONS = \(giphy.value.roundingCountSection(Constatnts.UI.countItemInSection))")
        return giphy.value.roundingCountSection(Constatnts.UI.countItemInSection)
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

    }

}

