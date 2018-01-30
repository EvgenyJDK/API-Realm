//
//  GifViewController.swift
//  AnimationApp
//
//  Created by Administrator on 29.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import UIKit

class GifViewController: UIViewController {
    
    @IBOutlet var aspectGifView: UIView!
    
    var giphy: Giphy? = nil
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        
        let leftItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(GifViewController.dismissVC))
        self.navigationItem.setLeftBarButton(leftItem, animated: false)

//        guard let giphy = giphy else { return }
//        if let url = giphy.preview {
//            let imageURL = UIImage.gifImageWithURL(url)
//            let gifImage = UIImageView(image: imageURL)
//            gifImage.frame = aspectGifView.frame
//            gifImage.autoresizingMask = UIViewAutoresizing.flexibleWidth
//            gifImage.contentMode = UIViewContentMode.scaleAspectFill
//            aspectGifView.addSubview(gifImage)
//        }
        
        
        
        let imageURL = UIImage.gifImageWithURL(url)
        let gifImage = UIImageView(image: imageURL)
        gifImage.frame = aspectGifView.frame
        gifImage.autoresizingMask = UIViewAutoresizing.flexibleWidth

        gifImage.contentMode = UIViewContentMode.scaleAspectFill
        aspectGifView.addSubview(gifImage)
    }
    
    @objc private func dismissVC() {
        _ = navigationController?.popToRootViewController(animated: false)
    }
 
}
