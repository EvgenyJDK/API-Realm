//
//  AppDelegate.swift
//  AnimationApp
//
//  Created by Administrator on 18.01.2018.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        AppReachability.shared.startListening()
        let firstLaunch = UserDefaults.standard.bool(forKey: Constatnts.UserDefaults.firstLaunch)

        return true
    }

}

