//
//  JTokenTests.swift
//  BeyovaJSONTests
//
//  Copyright © 2017 Beyova. All rights reserved.
//

import XCTest
@testable import BeyovaJSON

class JTokenTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCompare() {
        let x = JToken.init(2 as Int)
        let y = JToken.init(1 as Int8)
        XCTAssertTrue(x >= y)
    }
    
    func testNil() {
        var obj: JToken = ["key1": 1, "key2": [:]]
        _ = obj["key3"]["key"]
    }
    
    func testConvertable() {
        let val = Decimal(1.1) as JConvertable
        let r:Int8 = val.convert()
        XCTAssertEqual(r, 1)
    }
    
    func testSimple() {
        let val: JToken = "string1"
        print(val)
    }
    
    func testInt() {
        let val: JToken = 111111
        XCTAssertTrue(val.intValue == 111111)
    }
    
    func testData() {
        let s = "speaking"
        let data = Data(base64Encoded: s)!
        let val = JToken.init(data)
        XCTAssertEqual(val.bytesValue, data)
        let val2 = JToken.init(s)
        XCTAssertEqual(val2.bytesValue, data)
    }
    
    func testAppend() {
        var array: JToken = []
        array.append(1.1)
        array.append("test")
        print(array)
    }
    
    func testSetValue() {
        var dict: JToken = [:]
        dict["key1"] = 1.1
        let val = dict["key1"]
        XCTAssertNotNil(val)
        XCTAssertEqual(1, val.int)
    }
    
    func testJObjectIteration() {
        let dict: JToken = ["key1": 1.1,"key2": "value2"]
        for item in dict {
            print("key = \(item.key) value = \(item.value)")
        }
        print(dict)
    }
    
    func testJArrayIteration() {
        let array: JToken = [1.1,"test"]
        for item in array {
            print(item.key)
            print(item.value)
        }
    }
    
    func testNilIteration() {
        for _ in JToken.null {
            XCTAssert(false)
        }
        XCTAssertEqual(JToken.null.count, 0)
    }
    
    func testRaw() throws {
        let token: JToken = ["dateTest":Date(),"key1":1.1,"key2":["sub",1,["subsub"]]]
        let data = try token.rawData(formatting: .prettyPrinted)
        print(String(data: data, encoding: .utf8)!)
    }
}
