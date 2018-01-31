//
//  GifViewController.swift
//  AnimationApp
//
//  Created by Administrator on 29.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import UIKit
import SwiftGifOrigin

class GifViewController: UIViewController {
    
    @IBOutlet var aspectGifView: UIView!
    @IBOutlet weak var fullScreenGif: UIImageView!
    
    var giphy: Giphy? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureView()
    }
    
    private func configureNavigation() {
//        let leftItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(GifViewController.dismissVC))
//        self.navigationItem.setLeftBarButton(leftItem, animated: false)
    }
    
    private func configureView() {
        guard let giphy = giphy else { return }

        let path:String = giphy.fileUrl.path
        
//        fullScreenGif.image = UIImage.gifImageWithURL(path)
        
//        if let filePath = Bundle.main.path(forResource: "imageName", ofType: "gif"), let image = UIImage(contentsOfFile: path) {
////            imageView.contentMode = .scaleAspectFit
//            fullScreenGif.image = image
//        }


        let data = try? Data(contentsOf: giphy.fileUrl)
        fullScreenGif.image = UIImage.gif(data: data!)
        

// Animate GIF with SwiftGifOrigin
/*
         if let url = giphy.large {
         fullScreenGif.image = UIImage.gif(url: url)
         }
*/
        
// Animate GIF with UIImage + extensions
/*
        guard let giphy = giphy else { return }
        if let url = giphy.preview {
            let imageURL = UIImage.gifImageWithURL(url)
            let gifImage = UIImageView(image: imageURL)
            gifImage.frame = aspectGifView.frame
            gifImage.autoresizingMask = UIViewAutoresizing.flexibleWidth
            gifImage.contentMode = UIViewContentMode.scaleAspectFill
            aspectGifView.addSubview(gifImage)
        }
*/

    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: false) {
            
        }
        _ = navigationController?.popToRootViewController(animated: false)
    }
 
}
