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
    
    func loadImage(model: Giphy) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (model.fileUrl, [.removePreviousFile, .createIntermediateDirectories])
        }
        let request = Alamofire.download(model.preview!, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, to: destination)
        request.response { [weak self] (response) in
            if response.error == nil, let giphyPath = response.destinationURL?.path {
                print("----- CELL LOAD IMAGE = \(giphyPath)")

                let data = try? Data(contentsOf: model.fileUrl)
                self?.gifImageView.image = UIImage.gif(data: data!)
                model.isLoaded = true
            }
        }
    }
    
    func fillWith(model: Giphy) {
        idLabel.text = model.id
//        gifImageView.image = UIImage.gif(url: model.preview!)
//        StoreService.shared.store(giphy: model)

        print(model.fileUrl)
        

        if model.isLoaded {
            let data = try? Data(contentsOf: model.fileUrl)
            gifImageView.image = UIImage.gif(data: data!)
        } else {
            loadImage(model: model)
        }
        

// Convert image to Data
/*
         var image = UIImage()
         image = UIImage.gif(url: model.preview!)!
         let data = image.sd_imageData()
         gifImageView.image = UIImage.gif(data: data!)
*/
        

// Animate GIF with UIImage + extensions
/*
        let gifURL : String = model.preview!
        let imageURL = UIImage.gifImageWithURL(gifURL)
        let gifImage = UIImageView(image: imageURL)
        gifImage.frame = gifImageView.frame
        gifImage.autoresizingMask = UIViewAutoresizing.flexibleWidth
        gifImage.contentMode = UIViewContentMode.scaleAspectFill
        gifImageView.addSubview(gifImage)
*/
    }
    
}


