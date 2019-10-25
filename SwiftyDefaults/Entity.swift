//
//  Entity.swift
//  DefaultDemo2
//
//  Created by 周正飞 on 2019/6/19.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

class Entity<T: Preferenceible> {
    typealias ValueType = T
    private let key: String
    private let defaultValue: T
    private let userDefaults: UserDefaults
    
    init(key: String, defaultValue: T, userDefaults: UserDefaults) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }
    
    var value: T {
        get {
            return T.getValue(from: key, userDefaults: userDefaults) ?? defaultValue
        }
        set {
            T.saveValue(with: newValue, key: key, userDefaults: userDefaults)
        }
    }
}
