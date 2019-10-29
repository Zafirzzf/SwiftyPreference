//
//  DefaultConfig.swift
//  DefaultDemo2
//
//  Created by 周正飞 on 2019/6/19.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

public enum DefaultsScope {
    case global
    case loginUser
}

private let defaultSuitName = "com.wealoha.empty"

public class Defaults {
    fileprivate static var userSuitName: String = defaultSuitName
    
    public static func registCurrentUser(of userId: String) {
        userSuitName = userId
    }
    
    public static func logoutCurrentUser() {
        userSuitName = defaultSuitName
    }
}

@propertyWrapper
public struct DefaultsKey<P: Preferenceible> {
    
    private let key: String
    private let defaultValue: P
    private let defaults: UserDefaults
    
    public var projectedValue: Self {
      get { self }
      set { self = newValue }
    }
    
    public var wrappedValue: P {
        get {
            Entity<P>(key: key, defaultValue: defaultValue, userDefaults: defaults).value
        }
        set {
            Entity<P>(key: key, defaultValue: defaultValue, userDefaults: defaults).value = newValue
        }
    }
    
    public init(key: String, defaultValue: P, scope: DefaultsScope = .global) {
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
    
    public func remove() {
        defaults.removeObject(forKey: key)
    }
}
extension DefaultsKey where P: ExpressibleByNilLiteral {
    init(key: String, scope: DefaultsScope = .global) {
        self.key = key
        self.defaultValue = nil
        if scope == .loginUser {
            let userDefaults = UserDefaults(suiteName: Defaults.userSuitName)
            assert(userDefaults != nil)
            self.defaults = userDefaults ?? UserDefaults.standard
        } else {
            self.defaults = UserDefaults.standard
        }
    }
}