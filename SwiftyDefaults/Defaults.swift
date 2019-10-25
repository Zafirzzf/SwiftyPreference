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

private let notLoginUserSuitName = "com.wealoha.empty"

class Defaults {
    fileprivate static var loginUserId: String = notLoginUserSuitName
    
    static func registCurrentUser(of userId: String) {
        loginUserId = userId
    }
    
    static func logoutCurrentUser() {
        loginUserId = notLoginUserSuitName
    }
    
    static subscript<T: Preferenceible>(key: DefaultsKey<T>) -> T {
        get {
            Entity<T>(key: key.key, defaultValue: key.defaultValue, userDefaults: key.defaults).value
        }
        set {
            Entity<T>(key: key.key, defaultValue: key.defaultValue, userDefaults: key.defaults).value = newValue
        }
    }
    
    static func remove<T>(key: DefaultsKey<T>) {
        UserDefaults.standard.removeObject(forKey: key.key)
    }
}

class DefaultsKey<P: Preferenceible> {
    
    let key: String
    let defaultValue: P
    let defaults: UserDefaults
    
    init(key: String, defaultValue: P, scope: DefaultsScope = .global) {
        self.key = key
        self.defaultValue = defaultValue
        if scope == .loginUser {
            let userDefaults = UserDefaults(suiteName: Defaults.loginUserId)
            assert(userDefaults != nil)
            self.defaults = userDefaults ?? UserDefaults.standard
        } else {
            self.defaults = UserDefaults.standard
        }
    }
}

extension DefaultsKey where P: ExpressibleByNilLiteral {
    convenience init(key: String) {
        self.init(key: key, defaultValue: nil)
    }
}
