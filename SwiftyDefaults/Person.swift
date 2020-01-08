//
//  Person.swift
//  DefaultDemo2
//
//  Created by 周正飞 on 2019/6/21.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

struct Person: Preferenceible, Codable {
    var name: String = ""
    var age: Int = 0
    var height: Int = 0
    
    static func getValue(from key: String, userDefaults: UserDefaults) -> Person? {
        guard let data = userDefaults.value(forKey: key) as? Data else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return nil }
       var person = Person()
       person.name = json["name"] as? String ?? ""
       person.age = json["age"] as? Int ?? 0
       person.height = json["height"] as? Int ?? 0
       return person
    }
}

class Animal: Preferenceible, Codable {
    var name = "cat"
    init() {
        
    }
    init(name: String) {
        self.name = name
    }
}
