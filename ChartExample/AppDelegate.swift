//
//  AppDelegate.swift
//  ChartExample
//
//  Created by Lê Hoàng Sinh on 8/3/20.
//  Copyright © 2020 Lê Hoàng Sinh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
//        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        let vc = sb.instantiateViewController(withIdentifier: "TutorialViewController") as! TutorialViewController
        let navigationController = UINavigationController(rootViewController: vc)
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
                window?.rootViewController = navigationController
                window?.makeKeyAndVisible()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

