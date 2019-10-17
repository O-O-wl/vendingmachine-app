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
    
    /// - Todo: 반복되는 로직 제거 / 저장하는 객체 생성 고민
    
    var money: Money?
    // MARK: Assemble MVP
    var model: Inventory?
    
    var presenter: VendingMachinePresenter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        load()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        save()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        /// - Todo: 반복되는 로직 제거 / 저장하는 객체 생성 고민
        
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
            else { return  }
        UserDefaults.standard.set(encodedData, forKey: "VendingMachinePresenter")
    }
    
    func load() {
        /// - Todo: 반복되는 로직 제거
        if
            let encodedData = UserDefaults.standard.data(forKey: "VendingMachinePresenter"),
            let loadedPresenter = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData) as?  VendingMachinePresenter {
            presenter = loadedPresenter
            
        } else {
            money = Money(value: 0)
            model = Inventory(products: BeverageFactory.createAll(quantity: 1))
            presenter = VendingMachinePresenter(balance: money!,
                                                inventory: model!,
                                                history: History())
        }
        let view = window?.rootViewController as? VendingMachineViewController
        view?.presenter = presenter
    }
}
