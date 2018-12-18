//
//  AppDelegate.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 16/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureNavigationBar()
        showInitialView()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

//MARK: - Navigation methods
extension AppDelegate  {
    
    private func showInitialView() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationVC = CharactersListRouter.setupModule()
        
        self.window?.rootViewController = navigationVC
        self.window?.makeKeyAndVisible()
    }
        
    private func configureNavigationBar() {
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().barTintColor = .red
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barStyle = .blackOpaque
    }
    
}

