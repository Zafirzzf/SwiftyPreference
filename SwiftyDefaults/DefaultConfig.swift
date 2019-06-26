//
//  DefaultConfig.swift
//  DefaultDemo2
//
//  Created by 周正飞 on 2019/6/19.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

class DefaultConfig {
    static let theKey = "aaa"
    
    static let token = Entity<String>(key: theKey, defaultValue: "defaultValue")
    static let userId = Entity<String>(key: "llll")
    static let name = Entity<String?>(key: "bb")
    static let perosn = Entity<Person>(key: "dd", defaultValue: Person())
    static let person2 = Entity<Person?>(key: "zvxczcvx")
    static let photoType = Entity<TakePhotoType>(key: "cc", defaultValue: .front)
    static let photoType2 = Entity<TakePhotoType?>(key: "qwer")
}
