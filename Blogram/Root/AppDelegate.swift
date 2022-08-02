//
//  AppDelegate.swift
//  Blogram
//
//  Created by Islomjon on 15/06/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
//        let vc = TabBarVC()
//        window?.rootViewController = vc
        
        if UserDefaults.standard.bool(forKey: "isUserLogged"){
            let vc = TabBarVC()
            window?.rootViewController = vc
        }else{
            let vc = LoginVC(nibName: "LoginVC", bundle: nil)
            window?.rootViewController = vc
        }
        window?.makeKeyAndVisible()
        return true
    }
}

