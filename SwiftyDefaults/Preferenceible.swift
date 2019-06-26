//
//  Preferenceible.swift
//  SwiftyDefaults
//
//  Created by 周正飞 on 2019/6/26.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

protocol Preferenceible {
    associatedtype ValueType
    func getValue(from key: String) -> ValueType?
    func saveValue(with value: ValueType, key: String)
    func remove(with key: String)
}

extension Preferenceible {
    func getValue(from key: String) -> ValueType? {
        switch ValueType.self {
        case let defaultObject as PreferenceObjectible.Type:
            let data = UserDefaults.standard.value(forKey: key) as? Data
            return data.flatMap { defaultObject.decode(from: $0) }
                .flatMap { $0 as? ValueType }
        case let enumType as PreferenceEnumible.Type:
            let value = UserDefaults.standard.object(forKey: key)
            return value.flatMap { enumType.build(with: $0) }
                .flatMap { $0 as? ValueType }
        default:
            return UserDefaults.standard.object(forKey: key).flatMap { $0 as? ValueType }
        }
    }
    
    func saveValue(with value: ValueType, key: String) {
        switch value {
        case let object as PreferenceObjectible:
            UserDefaults.standard.set(object.toData, forKey: key)
        case let enumValue as PreferenceEnumible:
            UserDefaults.standard.set(enumValue.theRawValue, forKey: key)
        default:
            UserDefaults.standard.set(value, forKey: key)
        }
    }
    
    func remove(with key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
