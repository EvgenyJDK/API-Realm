//
//  ViewController.swift
//  AnimationApp
//
//  Created by Administrator on 18.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let giphyListViewModel = GiphyListViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "GIPHY"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateCollection()
        load()
    }

    private func configurateCollection() {
        collectionView.register(UINib(nibName: GiphyCell.classIdentifier, bundle: nil), forCellWithReuseIdentifier: String(describing: GiphyCell.self))
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiphyCell.classIdentifier, for: indexPath) as! GiphyCell

        return cell
    }
}


// MARK: - UICollectionViewDatasource

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}

