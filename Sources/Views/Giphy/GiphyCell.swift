//
//  GiphyCell.swift
//  AnimationApp
//
//  Created by Administrator on 23.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//


import UIKit
import Foundation
import SwiftGifOrigin
import Alamofire
import RxSwift


class GiphyCell: UICollectionViewCell {

    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        gifImageView.image = nil
    }
    
    func fillWith(model: Giphy) {
        idLabel.text = model.id
        if let data = try? Data(contentsOf: model.fileUrl) {
            gifImageView.image = UIImage.gif(data: data)
        }
    }
    
}


