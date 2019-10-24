//
//  SwiftyDefaultsTests.swift
//  SwiftyDefaultsTests
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
        XCTAssertTrue(Defaults[.token] == "defaultValue")
        Defaults[.token] = "xxx"
        XCTAssertTrue(Defaults[.token] == "xxx")
        XCTAssertTrue(Defaults[.userId] == "")
        XCTAssertTrue(Defaults[.name] == nil)
        Defaults[.name] = "ccc"
        XCTAssertTrue(Defaults[.name] == "ccc")
    }
    
    func testObjectTypeDefaultValue() {
        XCTAssertTrue(Defaults[.person].name == "zafir")
        XCTAssertTrue(Defaults[.person2]?.name == nil)
    }
    
    func testObjectTypeSetValue() {
        Defaults[.person] = Person(name: "aloha")
        XCTAssertTrue(Defaults[.person].name == "aloha")
    }
    
    func testOptionalObjectTypeSetValue() {
        Defaults[.person2] = nil
        XCTAssertTrue(Defaults[.person2] == nil)
        Defaults[.person2] = Person(name: "jackson")
        XCTAssertTrue(Defaults[.person2]?.name == "jackson")
    }
    
    func testEnumTypeDefaultValue() {
        XCTAssertTrue(Defaults[.photoType] == .front)
        XCTAssertTrue(Defaults[.photoType2] == nil)
    }
    
    func testEnumTypeSetValue() {
        Defaults[.photoType] = .front
        XCTAssertTrue(Defaults[.photoType] == .front)
    }
    
    func testOptionalEnumTypeSetValue() {
        Defaults[.photoType2] = nil
        XCTAssertTrue(Defaults[.photoType2] == nil)
        Defaults[.photoType2] = .back
        XCTAssertTrue(Defaults[.photoType2] == .back)
    }
    
    func testRemoveObject() {
        XCTAssertTrue(Defaults[.person].name == "zafir")
        Defaults[.person].name = "lele"
        XCTAssertTrue(Defaults[.person].name == "lele")
        Defaults.remove(key: .person)
        XCTAssertTrue(Defaults[.person].name == "zafir")
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
