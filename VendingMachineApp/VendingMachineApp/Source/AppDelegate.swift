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
    
    var money: Money?
    // MARK: Assemble MVP
    var model: Inventory?
    
    var presenter: VendingMachinePresenter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let encodedData = UserDefaults.standard.data(forKey: "Balance") {
                   money =  try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData) as! Money
               } else {
                   money = Money(value: 0)
               }
               
               model = Inventory(products: BeverageFactory.createAll(quantity: 1))
               presenter = VendingMachinePresenter(balance: money!,
                                                   inventory: model!,
                                                   history: History())
               //        let presenter = VendingMachinePresenter(balance: money,
               //                                                inventory: model,
               //                                                history: History())
               let view = window?.rootViewController as? VendingMachineViewController
               
               view?.presenter = presenter
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let encodedData = try! NSKeyedArchiver.archivedData(withRootObject: presenter!.balance,
                                                            requiringSecureCoding: false)
        UserDefaults.standard.set(encodedData, forKey: "Balance")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        if let encodedData = UserDefaults.standard.data(forKey: "Balance") {
            money =  try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData) as! Money
        } else {
            money = Money(value: 0)
        }
        
        model = Inventory(products: BeverageFactory.createAll(quantity: 1))
        presenter = VendingMachinePresenter(balance: money!,
                                            inventory: model!,
                                            history: History())
        //        let presenter = VendingMachinePresenter(balance: money,
        //                                                inventory: model,
        //                                                history: History())
        let view = window?.rootViewController as? VendingMachineViewController
        
        view?.presenter = presenter
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}
