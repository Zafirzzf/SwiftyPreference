//
//  DefaultKeys.swift
//  SwiftyDefaults
//
//  Created by 周正飞 on 2019/10/23.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

struct DefaultsConfig {
    @DefaultsKey(key: "token", defaultValue: "defaultValue")
    static var token: String
    
    @DefaultsKey(key: "userId", defaultValue: "")
       static var userId: String

    @DefaultsKey(key: "name")
       static var name: String?

    @DefaultsKey(key: "person", defaultValue: Person())
       static var person: Person
    
    @DefaultsKey(key: "person2")
       static var person2: Person?
    
    @DefaultsKey(key: "photoType", defaultValue: .front)
       static var photoType: TakePhotoType
    
    @DefaultsKey(key: "photoType2")
       static var photoType2: TakePhotoType?
    
    
    @DefaultsKey(key: "friends", defaultValue: [])
       static var friends: [String]
    
    @DefaultsKey(key: "family", defaultValue: [])
    static var family: [Person]
    
    @DefaultsKey(key: "user", type: .user)
    static var user: Person?
}


