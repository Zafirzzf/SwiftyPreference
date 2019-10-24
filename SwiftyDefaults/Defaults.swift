//
//  DefaultConfig.swift
//  DefaultDemo2
//
//  Created by 周正飞 on 2019/6/19.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

class Defaults {
    static subscript<T: Preferenceible>(key: DefaultsKey<T>) -> T {
        get {
            Entity<T>(key: key.key, defaultValue: key.defaultValue).value
        }
        set {
            Entity<T>(key: key.key, defaultValue: key.defaultValue).value = newValue
        }
    }
    
    static func remove<T>(key: DefaultsKey<T>) {
        UserDefaults.standard.removeObject(forKey: key.key)
    }
}

class DefaultsKey<P: Preferenceible> {
    
    let key: String
    let defaultValue: P
    
    init(key: String, defaultValue: P) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

extension DefaultsKey where P: ExpressibleByNilLiteral {
    convenience init(key: String) {
        self.init(key: key, defaultValue: nil)
    }
}
