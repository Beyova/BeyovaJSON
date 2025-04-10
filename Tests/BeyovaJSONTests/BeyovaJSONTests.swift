//
//  BeyovaJSONTests.swift
//  BeyovaJSON
//
//  Created by canius.chu on 22/2/2018.
//  Copyright © 2018 Beyova. All rights reserved.
//

import Foundation
import Testing
@testable import BeyovaJSON

@Test func testCoding() throws {
  let json:JSON = ["key1":1.1,"key2":["sub",1,NSNull(),["subsub"]],"key3":Date(),"key4": NSNull()]
  let decoder = JSONDecoder()
  let json2 = try decoder.decode(JSON.self, from: json.rawValue)
  #expect(json.description == json2.description)
}

@Test func testSubDecoding() throws {
  let obj = ["anyThing":["s":"s1","q":"q1","t":"t1"],"name":"name1"] as [String : Any]
  let data = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
  let decoder = JSONDecoder()
  let r = try decoder.decode(Customer.self, from: data)
  #expect((obj["name"] as! String) == r.name)
}

@Test func testSubEncoding() throws {
  let customer = Customer()
  let encoder = JSONEncoder()
  let data = try encoder.encode(customer)
  print(String(data: data, encoding: .utf8)!)
}

@Test func testEmpty() throws {
  let json1: JSON = [:]
  #expect("{}" == json1.description)
  let json2: JSON = []
  #expect("[]" == json2.description)
}

class User: Codable {
  
  var anyThing: JSON = .init()
}

class Customer: User {
  
  var name = ""
  
  private enum CodingKeys: String, CodingKey {
    case name
  }
  
  override init() { super.init() }
  
  required init(from decoder: Decoder) throws {
    do {
      try super.init(from: decoder)
      let container = try decoder.container(keyedBy: CodingKeys.self)
      if let val = try container.decodeIfPresent(String.self, forKey: .name) {
        name = val
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
    try container.encode(name, forKey: .name)
  }
}
