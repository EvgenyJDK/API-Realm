//
//  GifViewController.swift
//  AnimationApp
//
//  Created by Administrator on 29.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import UIKit

class GifViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var aspectGifView: UIView!
    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    
    var giphy: Giphy? = nil
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
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
    
    @IBAction func closeGifBoard(_ sender: Any) {
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: {
//                completion?()
            })
        }

    }
    
}
