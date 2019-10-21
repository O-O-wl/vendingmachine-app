//
//  UserDefaultsManager.swift
//  VendingMachineApp
//
//  Created by 이동영 on 21/10/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import Foundation

protocol Saveable {
    static var key: String { get }
}

struct UserDefaultsManager {
    
    private init() {}
    
    static func load<T: Saveable>(type: T.Type) -> T? {
        guard
            let data = UserDefaults.standard.data(forKey: type.key),
            let value = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
            else { return nil }
        return value
    }
    
   static func save<T: Saveable>(object: T) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: object,
                                                         requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: T.key)
        } catch let error {
            print("UserDefault Save Failure: \(error.localizedDescription)")
        }
        
    }
}
