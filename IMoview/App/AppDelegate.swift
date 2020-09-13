//
//  AppDelegate.swift
//  IMoview
//
//  Created by User on 9/8/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // initial
        let rootViewController = MainTabViewController()
        
        // setup window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootViewController
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
}

