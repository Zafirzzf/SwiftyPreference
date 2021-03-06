//
//  DefaultConfig.swift
//  DefaultDemo2
//
//  Created by 周正飞 on 2019/6/19.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

public enum DefaultsType {
    case device
    case user
}

public class Defaults {
    static let deviceDefaultsKey = "com.aloha.deviceDefaults"
    static let userDefaultsKey = "com.aloha.userDefaults"
    static var deviceDefaults = UserDefaults(suiteName: Defaults.deviceDefaultsKey) ?? UserDefaults.standard
    static var userDefaults = UserDefaults(suiteName: Defaults.userDefaultsKey) ?? UserDefaults.standard

    
    public static func registCurrentUser(of userId: String) {
        guard let tmpDefault = UserDefaults(suiteName: userDefaultsKey + userId) else { return }
        if !tmpDefault.dictionaryRepresentation().keys.isEmpty {
            tmpDefault.dictionaryRepresentation().forEach {
                userDefaults.set($0.value, forKey: $0.key)
            }
        }
    }
    
    public static func logout(with userId: String) {
        guard let theUserDefaults = UserDefaults(suiteName: userDefaultsKey + userId) else { return }
        userDefaults.dictionaryRepresentation().forEach {
            theUserDefaults.set($0.value, forKey: $0.key)
            userDefaults.removeObject(forKey: $0.key)
        }
        userDefaults = UserDefaults(suiteName: Defaults.userDefaultsKey) ?? UserDefaults.standard
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
    
    public init(key: String, defaultValue: P, type: DefaultsType = .user) {
        self.key = key
        self.defaultValue = defaultValue
        self.defaults = type == .device ? Defaults.deviceDefaults : Defaults.userDefaults
    }
    
    public func remove() {
        defaults.removeObject(forKey: key)
    }
}

extension DefaultsKey where P: ExpressibleByNilLiteral {
    init(key: String, type: DefaultsType = .user) {
        self.key = key
        self.defaultValue = nil
        self.defaults = type == .device ? Defaults.deviceDefaults : Defaults.userDefaults
    }
}
