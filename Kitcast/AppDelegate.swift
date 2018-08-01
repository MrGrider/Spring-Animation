//
//  AppDelegate.swift
//  Kitcast
//
//  Created by Alexander Grischenko on 3/12/18.
//  Copyright © 2018 grider. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()

        return true
    }

}

