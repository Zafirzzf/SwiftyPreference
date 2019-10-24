//
//  Preferenceible.swift
//  SwiftyDefaults
//
//  Created by 周正飞 on 2019/6/26.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

protocol Preferenceible {
    static func getValue(from key: String) -> Self?
    static func saveValue(with value: Self, key: String)
    static func remove(with key: String)
}

extension Preferenceible {
    static func getValue(from key: String) -> Self? {
        return UserDefaults.standard.object(forKey: key).flatMap { $0 as? Self }
    }
    
    static func saveValue(with value: Self, key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    static func remove(with key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

extension Preferenceible where Self: Codable {
    static func getValue(from key: String) -> Self? {
        let data = UserDefaults.standard.value(forKey: key) as? Data
        return data.flatMap { Self.decode(from: $0) }
    }
    
    static func saveValue(with value: Self, key: String) {
        UserDefaults.standard.set(value.toData, forKey: key)
    }
}

extension Preferenceible where Self: RawRepresentable {
    static func getValue(from key: String) -> Self? {
        (UserDefaults.standard.object(forKey: key) as? Self.RawValue).flatMap { Self.init(rawValue: $0) }
    }
       
    static func saveValue(with value: Self, key: String) {
        UserDefaults.standard.set(value.rawValue, forKey: key)
    }
}

extension Optional: Preferenceible where Wrapped: Preferenceible {
    static func getValue(from key: String) -> Optional<Wrapped>? {
        return Wrapped.getValue(from: key)
    }
    
    static func saveValue(with value: Optional<Wrapped>, key: String) {
        switch value {
        case .some(let value):
            Wrapped.saveValue(with: value, key: key)
        case .none:
            UserDefaults.standard.setValue(nil, forKey: key)
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

