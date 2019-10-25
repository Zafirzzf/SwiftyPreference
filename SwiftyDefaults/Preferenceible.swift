//
//  Preferenceible.swift
//  SwiftyDefaults
//
//  Created by 周正飞 on 2019/6/26.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

protocol Preferenceible {
    static func getValue(from key: String, userDefaults: UserDefaults) -> Self?
    static func saveValue(with value: Self, key: String, userDefaults: UserDefaults)
    static func remove(with key: String, userDefaults: UserDefaults)
}

extension Preferenceible {
    static func getValue(from key: String, userDefaults: UserDefaults) -> Self? {
        return userDefaults.object(forKey: key).flatMap { $0 as? Self }
    }
    
    static func saveValue(with value: Self, key: String, userDefaults: UserDefaults) {
        userDefaults.setValue(value, forKey: key)
    }
    
    static func remove(with key: String, userDefaults: UserDefaults) {
        userDefaults.removeObject(forKey: key)
    }
}

extension Preferenceible where Self: Codable {
    static func getValue(from key: String, userDefaults: UserDefaults) -> Self? {
        let data = userDefaults.value(forKey: key) as? Data
        return data.flatMap { Self.decode(from: $0) }
    }
    
    static func saveValue(with value: Self, key: String, userDefaults: UserDefaults) {
        userDefaults.set(value.toData, forKey: key)
    }
}

extension Preferenceible where Self: RawRepresentable {
    static func getValue(from key: String, userDefaults: UserDefaults) -> Self? {
        (userDefaults.object(forKey: key) as? Self.RawValue).flatMap { Self.init(rawValue: $0) }
    }
       
    static func saveValue(with value: Self, key: String, userDefaults: UserDefaults) {
        userDefaults.set(value.rawValue, forKey: key)
    }
}

extension Optional: Preferenceible where Wrapped: Preferenceible {
    static func getValue(from key: String, userDefaults: UserDefaults) -> Optional<Wrapped>? {
        return Wrapped.getValue(from: key, userDefaults: userDefaults)
    }
    
    static func saveValue(with value: Optional<Wrapped>, key: String, userDefaults: UserDefaults) {
        switch value {
        case .some(let value):
            Wrapped.saveValue(with: value, key: key, userDefaults: userDefaults)
        case .none:
            userDefaults.setValue(nil, forKey: key)
        }
    }
}

extension String: Preferenceible { }
extension Bool: Preferenceible { }
extension Int: Preferenceible { }
extension Double: Preferenceible { }
extension Float: Preferenceible { }
extension Data: Preferenceible { }
extension URL: Preferenceible { }
extension Date: Preferenceible { }
extension Array: Preferenceible { }
extension Dictionary: Preferenceible { }

