//
//  PreferenceModel.swift
//  AlohaKit_Example
//
//  Created by 周正飞 on 2019/11/28.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

public protocol PreferenceModel: Preferenceible {
    static var defaulsType: DefaultsType { get }
    static var preferencekey: String { get }
    static func fromPreferenceValue() -> Self?
    func saveToPreference()
}

extension PreferenceModel {
    public static var defaulsType: DefaultsType { .user }
    public static var preferencekey: String { "com.defaults.\(Self.self)" }
    
    private static var preference: DefaultsKey<Self?> {
        DefaultsKey<Self?>(key: preferencekey, type: defaulsType)
    }
    
    public static func fromPreferenceValue() -> Self? {
       return preference.wrappedValue
    }
    
    public func saveToPreference() {
        var preference = Self.preference
        preference.wrappedValue = self
    }
    
    public static func removePreference() {
        Self.preference.remove()
    }
}
