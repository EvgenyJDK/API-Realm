//
//  AppReachability.swift
//  AnimationApp
//
//  Created by Administrator on 29.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class AppReachability {
    
    static let shared = AppReachability()
    var isReachable: Variable<Bool?> = Variable(nil)
    private let reachability = NetworkReachabilityManager()
    
    func startListening() {
        reachability?.startListening()
        reachability?.listener = { [weak self] _ in
            self?.isReachable.value = self?.reachability?.isReachable ?? false
        }
    }
}
