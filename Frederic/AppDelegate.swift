//
//  AppDelegate.swift
//  Frederic
//
//  Created by Carlos Jimenez on 11-10-19.
//  Copyright © 2019 Carlos Jimenez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let navController = UINavigationController(rootViewController: UIViewController())
        window?.rootViewController = navController
        return true
    }

}
