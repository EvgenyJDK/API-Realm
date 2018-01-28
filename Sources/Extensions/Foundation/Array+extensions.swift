//
//  Array+extension.swift
//  AnimationApp
//
//  Created by Administrator on 28.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation

extension Array {
    public func roundingCountSection(_ item: Int) -> Int {
//        print("------------")
//        print(self.count)
//        print(self.count % item)
        if self.count % item == 0 { return self.count / item }
        return self.count / item
    }
}
