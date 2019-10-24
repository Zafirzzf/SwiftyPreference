//
//  Person.swift
//  DefaultDemo2
//
//  Created by 周正飞 on 2019/6/21.
//  Copyright © 2019 周正飞. All rights reserved.
//

import Foundation

struct Person: PreferenceObjectible, Codable {
    var name = "zafir"
}

class Animal: PreferenceObjectible {
    var name = "cat"
    init() {
        
    }
    init(name: String) {
        self.name = name
    }
}
