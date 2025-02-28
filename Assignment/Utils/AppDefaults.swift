//
//  AppDefaults.swift
//  Assignment
//
//  Created by droadmin on 2/28/25.
//

import Foundation

class AppDefaults{
    
    enum AppDefaultsKeys: String{
        case DeviceData = "DeviceData"
        case LastUpdatedDate = "LastUpdatedData"
    }
    
    static let shared = AppDefaults()
    
    private init() {}
    
    func getDefaultValue(for key: AppDefaultsKeys) -> Any?{
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    func storeValue(for key: AppDefaultsKeys, value: Any?){
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func removeValue(for key: AppDefaultsKeys){
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
}
