//
//  GiphyCell.swift
//  AnimationApp
//
//  Created by Administrator on 23.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//


import UIKit
import Foundation


class GiphyCell: UICollectionViewCell {

    @IBOutlet weak var gifImageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
    func fillWith(model: Giphy) {
        
        idLabel.text = model.id
        let gifURL : String = model.preview!
        let imageURL = UIImage.gifImageWithURL(gifURL)
        let gifImage = UIImageView(image: imageURL)
        gifImage.frame = gifImageView.frame
        gifImage.autoresizingMask = UIViewAutoresizing.flexibleWidth

        gifImage.contentMode = UIViewContentMode.scaleAspectFill
        gifImageView.addSubview(gifImage)
//        gifImageView = UIImageView(image: imageURL)
    
    }
    
}


