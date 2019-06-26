//
//  Entity.swift
//  DefaultDemo2
//
//  Created by 周正飞 on 2019/6/19.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

class Entity<T>: Preferenceible {
    typealias ValueType = T
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var value: T {
        get {
            return getValue(from: key) ?? defaultValue
        }
        set {
            saveValue(with: newValue, key: key)
        }
    }
    
    func remove() {
        remove(with: key)
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
