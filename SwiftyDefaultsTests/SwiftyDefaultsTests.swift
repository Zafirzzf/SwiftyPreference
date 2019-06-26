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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testNormalType() {
        XCTAssertTrue(DefaultConfig.token.value == "defaultValue")
        DefaultConfig.token.value = "xxx"
        XCTAssertTrue(DefaultConfig.token.value == "xxx")
        XCTAssertTrue(DefaultConfig.userId.value == "")
        XCTAssertTrue(DefaultConfig.name.value == nil)
        DefaultConfig.name.value = "ccc"
        XCTAssertTrue(DefaultConfig.name.value == "ccc")
    }
    
    func testObjectTypeDefaultValue() {
        XCTAssertTrue(DefaultConfig.perosn.value.name == "zafir")
        XCTAssertTrue(DefaultConfig.person2.value?.name == nil)
    }
    
    func testObjectTypeSetValue() {
        DefaultConfig.perosn.value = Person(name: "aloha")
        XCTAssertTrue(DefaultConfig.perosn.value.name == "aloha")
    }
    
    func testOptionalObjectTypeSetValue() {
        DefaultConfig.person2.remove()
        XCTAssertTrue(DefaultConfig.person2.value == nil)
        DefaultConfig.person2.value = Person(name: "jackson")
        XCTAssertTrue(DefaultConfig.person2.value?.name == "jackson")
    }
    
    func testEnumTypeDefaultValue() {
        XCTAssertTrue(DefaultConfig.photoType.value == .front)
        XCTAssertTrue(DefaultConfig.photoType2.value == nil)
    }
    
    func testEnumTypeSetValue() {
        DefaultConfig.photoType.value = .front
        XCTAssertTrue(DefaultConfig.photoType.value == .front)
    }
    
    func testOptionalEnumTypeSetValue() {
        DefaultConfig.photoType2.remove()
        XCTAssertTrue(DefaultConfig.photoType2.value == nil)
        DefaultConfig.photoType2.value = .back
        XCTAssertTrue(DefaultConfig.photoType2.value == .back)
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
