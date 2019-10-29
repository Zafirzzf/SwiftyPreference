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
    
    var defaults: UserDefaults? {
        if self == .loginUser {
            return Defaults.userSuitName.flatMap { UserDefaults(suiteName: $0) }
        } else {
            return .standard
        }
    }
}

public class Defaults {
    fileprivate static var userSuitName: String?
    
    public static func registCurrentUser(of userId: String) {
        userSuitName = userId
    }
    
    public static func logoutCurrentUser() {
        userSuitName = nil
    }
}

@propertyWrapper
public struct DefaultsKey<P: Preferenceible> {
    
    private let key: String
    private let defaultValue: P
    private var defaults: UserDefaults?
    
    public var wrappedValue: P {
        get {
            if let defaults = defaults {
                return Entity<P>(key: key, defaultValue: defaultValue, userDefaults: defaults).value
            } else {
                return defaultValue
            }
        }
        set {
            if let defaults = defaults {
                Entity<P>(key: key, defaultValue: defaultValue, userDefaults: defaults).value = newValue
            }
        }
    }
    
    public init(key: String, defaultValue: P, scope: DefaultsScope = .global) {
        self.key = key
        self.defaultValue = defaultValue
        self.defaults = scope.defaults
    }
}
extension DefaultsKey where P: ExpressibleByNilLiteral {
    init(key: String, scope: DefaultsScope = .global) {
        self.key = key
        self.defaultValue = nil
        self.defaults = scope.defaults
    }
}
