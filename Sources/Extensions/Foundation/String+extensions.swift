//
//  String+extension.swift
//  AnimationApp
//
//  Created by Administrator on 23.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation

extension String {
    var lastComponent: String? {
        return self.components(separatedBy: ".").last
    }
}
