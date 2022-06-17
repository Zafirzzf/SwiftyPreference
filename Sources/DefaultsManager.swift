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

public class DefaultsManager {
    static let deviceDefaultsKey = "com.aloha.deviceDefaults"
    static let userDefaultsKey = "com.aloha.userDefaults"
    static var deviceDefaults = UserDefaults(suiteName: DefaultsManager.deviceDefaultsKey) ?? UserDefaults.standard
    static var userDefaults = UserDefaults(suiteName: DefaultsManager.userDefaultsKey) ?? UserDefaults.standard

    
    public static func registCurrentUser(of userId: String) {
        guard let tmpDefault = UserDefaults(suiteName: userDefaultsKey + userId) else { return }
        tmpDefault.dictionaryRepresentation().forEach {
            userDefaults.set($0.value, forKey: $0.key)
        }
    }
    
    public static func logout(with userId: String) {
        guard let theUserDefaults = UserDefaults(suiteName: userDefaultsKey + userId) else { return }
        userDefaults.dictionaryRepresentation().forEach {
            theUserDefaults.set($0.value, forKey: $0.key)
            userDefaults.removeObject(forKey: $0.key)
        }
    }
    
    public static func directlySet(_ value: Any, for key: String, defaultsType: DefaultsType) {
        let defaults = defaultsType == .device ? deviceDefaults : userDefaults
        defaults.setValue(value, forKey: key)
    }
}

@propertyWrapper
public struct DefaultsKey<T: Preferenceible> {
    
    let key: String
    let defaultValue: T
    let defaults: UserDefaults
    
    public var projectedValue: Self {
      get { self }
      set { self = newValue }
    }
    
    public var wrappedValue: T {
        get {
            T.getValue(from: key, userDefaults: defaults) ?? defaultValue
        }
        set {
            T.saveValue(with: newValue, key: key, userDefaults: defaults)
        }
    }
    
    public init(key: String, defaultValue: T, type: DefaultsType = .user) {
        self.key = key
        self.defaultValue = defaultValue
        self.defaults = type == .device ? DefaultsManager.deviceDefaults : DefaultsManager.userDefaults
    }
    
    public func remove() {
        defaults.removeObject(forKey: key)
    }
}

extension DefaultsKey where T: ExpressibleByNilLiteral {
    public init(key: String, type: DefaultsType = .user) {
        self.key = key
        self.defaultValue = nil
        self.defaults = type == .device ? DefaultsManager.deviceDefaults : DefaultsManager.userDefaults
    }
}
