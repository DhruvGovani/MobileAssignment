//
//  APICacheManager.swift
//  Assignment
//
//  Created by droadmin on 2/28/25.
//

import Foundation

class APICacheManager{
    
    static let shared = APICacheManager()
    
    private init() {}
    
    func storeCache(data: Data){
        AppDefaults.shared.storeValue(for: .DeviceData, value: data)
        AppDefaults.shared.storeValue(for: .LastUpdatedDate, value: Date())
    }
    
    func getDeviceDataCache() -> [DeviceData]?{
        if let lastUpdatedDate = AppDefaults.shared.getDefaultValue(for: .LastUpdatedDate) as? Date{
            let components = Calendar.current.dateComponents([.second], from: lastUpdatedDate, to: Date())
            if (components.second ?? 45) < 45{ // Will return the data from cache if data is stored only 30 seconds ago
                if let deviceData = AppDefaults.shared.getDefaultValue(for: .DeviceData) as? Data{
                    return try? JSONDecoder().decode([DeviceData].self, from: deviceData)
                } else {
                    return nil
                }
            } else {
                AppDefaults.shared.removeValue(for: .DeviceData)
                AppDefaults.shared.removeValue(for: .LastUpdatedDate)
                return nil
            }
        } else {
            return nil
        }
    }
}
