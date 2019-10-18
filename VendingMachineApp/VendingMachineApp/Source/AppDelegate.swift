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
    
    var presenter: VendingMachinePresenterType?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        load()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        save()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        save()
    }
    
}
// + UIApplicationDelegate
extension AppDelegate {
    
    func save() {
        guard
            let savingPresenter = presenter,
            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: savingPresenter,
                                                                requiringSecureCoding: false)
            else { return }
        
        UserDefaults.standard.set(encodedData, forKey: "VendingMachinePresenter")
    }
    
    func load() {
        guard
            let view = window?.rootViewController as? VendingMachineViewController
            else { return }
        if
            let encodedData = UserDefaults.standard.data(forKey: "VendingMachinePresenter"),
            let loadedPresenter = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData) as?  VendingMachinePresenter {
            presenter = loadedPresenter
            
        } else {
            let money = Money(value: 0)
            let model = Inventory(products: BeverageFactory.createAll(quantity: 1))
            presenter = VendingMachinePresenter(balance: money,
                                                inventory: model,
                                                history: History())
            
        }
        view.presenter = presenter
    }
    
}
