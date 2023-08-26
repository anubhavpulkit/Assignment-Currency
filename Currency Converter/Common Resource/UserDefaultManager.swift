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
        defaults.set(keywordsArray, forKey: "setBaseCodeHistory")
        defaults.synchronize()
    }
    func getBaseCodeHistory() -> [String] {
        guard let lastSearchKeyword = defaults.value(forKey: "setBaseCodeHistory") as? [String] else {
            return []
        }
        return lastSearchKeyword
    }
    
    func setTargetCodeHistory(keywordsArray : [String]){
        defaults.set(keywordsArray, forKey: "setTargetCodeHistory")
        defaults.synchronize()
    }
    func getTargetCodeHistory() -> [String] {
        guard let lastSearchKeyword = defaults.value(forKey: "setTargetCodeHistory") as? [String] else {
            return []
        }
        return lastSearchKeyword
    }
    
    func setHistoryAmount(keywordsArray : [String]){
        defaults.set(keywordsArray, forKey: "setHistoryAmount")
        defaults.synchronize()
    }
    func getHistoryAmount() -> [String] {
        guard let lastSearchKeyword = defaults.value(forKey: "setHistoryAmount") as? [String] else {
            return []
        }
        return lastSearchKeyword
    }
    
    func setHistoryConvertedAmount(keywordsArray : [Float]){
        defaults.set(keywordsArray, forKey: "setHistoryConvertedAmount")
        defaults.synchronize()
    }
    func getHistoryConvertedAmount() -> [Float] {
        guard let lastSearchKeyword = defaults.value(forKey: "setHistoryConvertedAmount") as? [Float] else {
            return []
        }
        return lastSearchKeyword
    }
    
    func setHistroyConversionRate(keywordsArray : [Float]){
        defaults.set(keywordsArray, forKey: "setHistroyConversionRate")
        defaults.synchronize()
    }
    func getHistroyConversionRatet() -> [Float] {
        guard let lastSearchKeyword = defaults.value(forKey: "setHistroyConversionRate") as? [Float] else {
            return []
        }
        return lastSearchKeyword
    }
    
    func setDateHistory(keywordsArray : [String]){
        defaults.set(keywordsArray, forKey: "setDateHistory")
        defaults.synchronize()
    }
    func getDateHistory() -> [String] {
        guard let lastSearchKeyword = defaults.value(forKey: "setDateHistory") as? [String] else {
            return []
        }
        return lastSearchKeyword
    }
    
    func setTimeHistory(keywordsArray : [String]){
        defaults.set(keywordsArray, forKey: "setTimeHistory")
        defaults.synchronize()
    }
    func getTimeHistory() -> [String] {
        guard let lastSearchKeyword = defaults.value(forKey: "setTimeHistory") as? [String] else {
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
