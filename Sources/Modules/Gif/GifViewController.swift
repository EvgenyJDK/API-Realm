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
//        configureNavigation()
        configureView()
    }
    
    private func configureNavigation() {
        let leftItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(GifViewController.dismissVC))
        self.navigationItem.setLeftBarButton(leftItem, animated: false)
    }
    
    private func configureView() {
        guard let giphy = giphy else { return }
        if let data = try? Data(contentsOf: giphy.fileUrl) {
            fullScreenGif.image = UIImage.gif(data: data)
        }
    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: false) {
        }
        _ = navigationController?.popToRootViewController(animated: false)
    }
}
