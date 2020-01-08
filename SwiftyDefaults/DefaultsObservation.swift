//
//  DefaulsObservation.swift
//  SwiftyDefaults
//
//  Created by 周正飞 on 2020/1/8.
//  Copyright © 2020 周正飞. All rights reserved.
//

import Foundation


class DefaultsObservation<T: Preferenceible>: NSObject {
    private let key: String
    private let onChange: (T) -> Void
    private let defaults: UserDefaults
    
    deinit {
        defaults.removeObserver(self, forKeyPath: key, context: nil)
    }
    
    init(key: String, defaults: UserDefaults, onChange: @escaping (T) -> Void) {
        self.key = key
        self.onChange = onChange
        self.defaults = defaults
        super.init()
        defaults.addObserver(self, forKeyPath: key, options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard change != nil, object != nil, keyPath == key else { return }
        guard let newValue = T.getValue(from: key, userDefaults: defaults) else { return }
        onChange(newValue)
    }
}
