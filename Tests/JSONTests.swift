//
//  JSONTests.swift
//  BeyovaJSON
//
//  Created by canius.chu on 22/2/2018.
//  Copyright © 2018 Beyova. All rights reserved.
//

import XCTest
@testable import BeyovaJSON

class User: Codable {
    var AnyThing: JSON = .init()
}

class Customer: User {
    var Name = ""
    private enum CodingKeys: String, CodingKey {
        case Name
    }
    override init() { super.init() }
    required init(from decoder: Decoder) throws {
        do {
            try super.init(from: decoder)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let val = try container.decodeIfPresent(String.self, forKey: .Name) {
                Name = val
            }
        }
        catch let err {
            print(err)
            throw err
        }
    }
    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Name, forKey: .Name)
    }
    
}


class JSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCoding() {
        let json:JSON = ["key1":1.1,"key2":["sub",1,["subsub"]], "key3":Date()]
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(json)
        let s = String(bytes: data, encoding: .utf8)!
        print(s)
        
        let decoder = JSONDecoder()
        let json2 = try! decoder.decode(JSON.self, from: data)
        
        print(json2.value)
    }
    
    func testSubDecoding() throws {
        let obj = ["AnyThing": ["s":"s1","q":"q1","t":"t1"], "Name": "name1"] as [String : Any]
        let data = try! JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
        print(String(data: data, encoding: .utf8)!)
        let decoder = JSONDecoder()
        let r = try decoder.decode(Customer.self, from: data)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let bytes = try encoder.encode(r)
        let s = String(bytes: bytes, encoding: .utf8)!
        print(s)
        XCTAssertEqual(obj["Name"] as! String, r.Name)
    }

}
