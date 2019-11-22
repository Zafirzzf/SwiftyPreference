//
//  SwiftyDefaultsConfigTests.swift
//  SwiftyDefaultsConfigTests
//
//  Created by 周正飞 on 2019/6/26.
//  Copyright © 2019 周正飞. All rights reserved.
//

import XCTest
@testable import SwiftyDefaults

class SwiftyDefaultsTests: XCTestCase {

    override func setUp() {
        
        UserDefaults.standard.dictionaryRepresentation().forEach {
            UserDefaults.standard.removeObject(forKey: $0.key)
        }
    }

    func testNormalType() {
        XCTAssertTrue(DefaultsConfig.token == "defaultValue")
        DefaultsConfig.token = "xxx"
        XCTAssertTrue(DefaultsConfig.token == "xxx")
        XCTAssertTrue(DefaultsConfig.userId == "")
        XCTAssertTrue(DefaultsConfig.name == nil)
        DefaultsConfig.name = "ccc"
        XCTAssertTrue(DefaultsConfig.name == "ccc")
    }
    
    func testObjectTypeDefaultValue() {
        XCTAssertTrue(DefaultsConfig.person.name == "zafir")
        XCTAssertTrue(DefaultsConfig.person2?.name == nil)
    }
    
    func testObjectTypeSetValue() {
        DefaultsConfig.person = Person(name: "aloha")
        XCTAssertTrue(DefaultsConfig.person.name == "aloha")
    }
    
    func testOptionalObjectTypeSetValue() {
        DefaultsConfig.person2 = nil
        XCTAssertTrue(DefaultsConfig.person2 == nil)
        DefaultsConfig.person2 = Person(name: "jackson")
        XCTAssertTrue(DefaultsConfig.person2?.name == "jackson")
    }
    
    func testEnumTypeDefaultValue() {
        XCTAssertTrue(DefaultsConfig.photoType == .front)
        XCTAssertTrue(DefaultsConfig.photoType2 == nil)
    }
    
    func testEnumTypeSetValue() {
        DefaultsConfig.photoType = .front
        XCTAssertTrue(DefaultsConfig.photoType == .front)
    }
    
    func testOptionalEnumTypeSetValue() {
        DefaultsConfig.photoType2 = nil
        XCTAssertTrue(DefaultsConfig.photoType2 == nil)
        DefaultsConfig.photoType2 = .back
        XCTAssertTrue(DefaultsConfig.photoType2 == .back)
    }
    
    func testRemoveObject() {
        XCTAssertTrue(DefaultsConfig.person.name == "zafir")
        DefaultsConfig.person.name = "lele"
        XCTAssertTrue(DefaultsConfig.person.name == "lele")
        DefaultsConfig.$person.remove()
        XCTAssertTrue(DefaultsConfig.person.name == "zafir")
    }

    func testBasicArray() {
        DefaultsConfig.friends = ["a", "bc"]
        XCTAssertTrue(DefaultsConfig.friends == ["a", "bc"])
        DefaultsConfig.friends = []
        XCTAssertTrue(DefaultsConfig.friends == [])
    }
    
    func testObjectArray() {
        DefaultsConfig.family = [Person(name: "a"), Person(name: "b")]
        XCTAssertTrue(DefaultsConfig.family.count == 2)
    }
    
    func testLoginAndLogout() {
        DefaultsConfig.user = Person(name: "aa")
        Defaults.registCurrentUser(of: "userId")
        XCTAssert(DefaultsConfig.user?.name == "aa")
        Defaults.logout(with: "userId")
        XCTAssert(DefaultsConfig.user?.name == nil)
        Defaults.registCurrentUser(of: "userId")
        XCTAssert(DefaultsConfig.user?.name == "aa")
        Defaults.logout(with: "userId")
        Defaults.registCurrentUser(of: "userId2")
        DefaultsConfig.user = Person(name: "bb")
        Defaults.logout(with: "userId2")
        XCTAssert(DefaultsConfig.user?.name == nil)
        Defaults.registCurrentUser(of: "userId")
        XCTAssert(DefaultsConfig.user?.name == "aa")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
