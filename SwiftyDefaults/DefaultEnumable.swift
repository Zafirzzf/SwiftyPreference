//
//  PreferenceEnumable.swift
//  DefaultDemo2
//
//  Created by 周正飞 on 2019/6/21.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

/// 使枚举可以存储到UserDefault
protocol DefaultEnumable {
    var theRawValue: Any? { get }
    static func build(with value: Any?) -> Self?
}

extension RawRepresentable where Self: DefaultEnumable {
    var theRawValue: Any? {
        return self.rawValue
    }
    static func build(with value: Any?) -> Self? {
        guard let theValue = value as? RawValue else { return nil }
        return Self.init(rawValue: theValue)
    }
}

extension Optional: DefaultEnumable where Wrapped: DefaultEnumable {
    var theRawValue: Any? {
        switch self {
        case .some(let wrapped):
            return wrapped.theRawValue
        case .none:
            return nil
        }
    }
    
    static func build(with value: Any?) -> Optional<Wrapped>? {
        guard let value = value else { return nil }
        return Wrapped.build(with: value)
    }
}
