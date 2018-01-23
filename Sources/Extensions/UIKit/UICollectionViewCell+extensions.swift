//
//  UICollectionViewCell+extension.swift
//  AnimationApp
//
//  Created by Administrator on 23.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import Foundation

extension UICollectionViewCell {
    class var classIdentifier: String {
        let classIdentifier = NSStringFromClass(self)
        guard let indentifier = classIdentifier.lastComponent else { fatalError("Class no found with name" + classIdentifier) }
        return indentifier
    }
}
