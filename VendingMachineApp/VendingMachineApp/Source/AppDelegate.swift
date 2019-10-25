//
//  AppDelegate.swift
//  VendingMachineApp
//
//  Created by 이동영 on 23/09/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard
            var view = window?.rootViewController as? VendingMachineViewType
            else { return true }
        view.service = VendingMachineService.shared
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        UserDefaultsManager.save(object: VendingMachineService.shared)
        VendingMachineService.destory()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        guard
            var view = window?.rootViewController as? VendingMachineViewType
            else { return }
        view.service = VendingMachineService.shared
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaultsManager.save(object: VendingMachineService.shared)
        VendingMachineService.destory()
    }
    
}
