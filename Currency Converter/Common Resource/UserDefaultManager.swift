//
//  UserDefaultManager.swift
//  Currency Converter
//
//  Created by Anubhav-iOS on 25/08/23.
//

import Foundation

class UserDefaultManager: NSObject {
    
    static let standard = UserDefaultManager()
    let defaults = UserDefaults.standard
    
    func setBaseCodeHistory(keywordsArray : [String]){
        defaults.set(keywordsArray, forKey: "BaseCodeHistory")
        defaults.synchronize()
    }
    
    func getBaseCodeHistory() -> [String] {
        guard let lastSearchKeyword = defaults.value(forKey: "BaseCodeHistory") as? [String] else {
            return []
        }
        return lastSearchKeyword
    }
}

@propertyWrapper
struct StorageRef<T> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}
