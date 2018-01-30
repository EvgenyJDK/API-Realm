//
//  GiphyCell.swift
//  AnimationApp
//
//  Created by Administrator on 23.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//


import UIKit
import Foundation
import SDWebImage
import SwiftGifOrigin

class GiphyCell: UICollectionViewCell {

    @IBOutlet weak var gifImageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gifImageView.image = nil
    }
    
    func fillWith(model: Giphy) {
        idLabel.text = model.id
        gifImageView.image = UIImage.gif(url: model.preview!)
        StoreService.shared.store(giphy: model)
        
//        gifImageView.sd_setImage(with: NSURL(fileURLWithPath: model.preview!) as URL) { (uiImage, error, sdImageCasheType, url) in
//        }
        
//        let gifURL : String = model.preview!
//        let imageURL = UIImage.gifImageWithURL(gifURL)
//        let gifImage = UIImageView(image: imageURL)
//        gifImage.frame = gifImageView.frame
//        gifImage.autoresizingMask = UIViewAutoresizing.flexibleWidth
//        gifImage.contentMode = UIViewContentMode.scaleAspectFill
//        gifImageView.addSubview(gifImage)
////        gifImageView = UIImageView(image: imageURL)
    
    }
    
}


