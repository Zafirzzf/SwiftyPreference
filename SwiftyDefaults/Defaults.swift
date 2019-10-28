//
//  DefaultConfig.swift
//  DefaultDemo2
//
//  Created by 周正飞 on 2019/6/19.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

enum DefaultsScope {
    case global
    case loginUser
}

private let defaultSuitName = "com.wealoha.empty"

class Defaults {
    fileprivate static var userSuitName: String = defaultSuitName
    
    static func registCurrentUser(of userId: String) {
        userSuitName = userId
    }
    
    static func logoutCurrentUser() {
        userSuitName = defaultSuitName
    }
}


@propertyWrapper
struct DefaultsKey<P: Preferenceible> {
    
    let key: String
    let defaultValue: P
    let defaults: UserDefaults
    
    var wrappedValue: P {
        get {
            Entity<P>(key: key, defaultValue: defaultValue, userDefaults: defaults).value
        }
        set {
            Entity<P>(key: key, defaultValue: defaultValue, userDefaults: defaults).value = newValue
        }
    }
    
    init(key: String, defaultValue: P, scope: DefaultsScope = .global) {
        self.key = key
        self.defaultValue = defaultValue
        if scope == .loginUser {
            let userDefaults = UserDefaults(suiteName: Defaults.userSuitName)
            assert(userDefaults != nil)
            self.defaults = userDefaults ?? UserDefaults.standard
        } else {
            self.defaults = UserDefaults.standard
        }
    }
}
