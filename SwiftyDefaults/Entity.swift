//
//  Entity.swift
//  DefaultDemo2
//
//  Created by 周正飞 on 2019/6/19.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

class Entity<T> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var value: T {
        get {
            return getValue()
        }
        set {
            saveValue(with: newValue)
        }
    }
    
    func remove() {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    private func getValue() -> T {
        switch T.self {
        case let defaultObject as DefaultObjectable.Type:
            let data = UserDefaults.standard.value(forKey: key) as? Data
            return data.flatMap { defaultObject.decode(from: $0) }
                .flatMap { $0 as? T } ?? defaultValue
        case let enumType as DefaultEnumable.Type:
            let value = UserDefaults.standard.object(forKey: key)
            return value.flatMap { enumType.build(with: $0) }
                .flatMap { $0 as? T } ?? defaultValue
        default:
            return UserDefaults.standard.object(forKey: key).flatMap { $0 as? T } ?? defaultValue
        }
    }
    
    private func saveValue(with value: T) {
        switch value {
        case let object as DefaultObjectable:
            UserDefaults.standard.set(object.toData, forKey: key)
        case let enumValue as DefaultEnumable:
            UserDefaults.standard.set(enumValue.theRawValue, forKey: key)
        default:
            UserDefaults.standard.set(value, forKey: key)
        }
    }
}

// MARK: - 为特定Type添加对应Type的defaultValue
extension Entity where T: ExpressibleByNilLiteral {
    convenience init(key: String) {
        self.init(key: key, defaultValue: nil)
    }
}

extension Entity where T == String {
    convenience init(key: String) {
        self.init(key: key, defaultValue: "")
    }
}
