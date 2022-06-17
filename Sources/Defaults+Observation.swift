//
//  Defaults+Observation.swift
//  SwiftyDefaults
//
//  Created by 周正飞 on 2020/3/12.
//  Copyright © 2020 周正飞. All rights reserved.
//

import Foundation

extension DefaultsKey {
    public func observe(change: @escaping (_ newVaue: T) -> Void) -> ObservationRemovable {
        DefaultsObservation(key: key, defaults: defaults, onChange: change)
    }
}

public protocol ObservationRemovable: NSObject {
    func removeObserver()
}

public class DefaultsObservation<T: Preferenceible>: NSObject, ObservationRemovable {
    
    let key: String
    let onChange: (T) -> Void
    let defaults: UserDefaults
    
    deinit {
        removeObserver()
    }
    
    public init(key: String, defaults: UserDefaults, onChange: @escaping (T) -> Void) {
        self.key = key
        self.onChange = onChange
        self.defaults = defaults
        super.init()
        defaults.addObserver(self, forKeyPath: key, options: [.old, .new], context: nil)
    }
    
    public func removeObserver() {
        defaults.removeObserver(self, forKeyPath: key, context: nil)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard change != nil, object != nil, keyPath == key else { return }
        guard let newValue = T.getValue(from: key, userDefaults: defaults) else { return }
        onChange(newValue)
    }
}
