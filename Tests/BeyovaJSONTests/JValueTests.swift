//
//  JValueTests.swift
//  BeyovaJSON
//
//  Created by canius.chu on 22/2/2018.
//  Copyright © 2018 Beyova. All rights reserved.
//

import Foundation
import Testing
@testable import BeyovaJSON

@Suite("JValue Codable Tests")
struct JValueTests {
  
  @Test func testEncode() throws {
    let json: JValue = ["key1":nil,"key2":1,"key3":1.1,"key4":[1,nil,"a"]]
    let string = #"{"key1":null,"key2":1,"key3":1.1,"key4":[1,null,"a"]}"#
    #expect(json.debugDescription == string)
  }
  @Test func testDecode() throws {
    let json: JValue = ["key1":nil,"key2":1,"key3":1.1,"key4":[1,nil,"a"]]
    let string = #"{"key1":null,"key2":1,"key3":1.1,"key4":[1,null,"a"]}"#
    let data = string.data(using: .utf8)!
    let decoder = JSONDecoder()
    let decoded = try decoder.decode(JValue.self, from: data)
    #expect(json == decoded)
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
    customer.anyThing = 1
    let encoder = JSONEncoder()
    encoder.outputFormatting = .sortedKeys
    let data = try encoder.encode(customer)
    #expect(String(data: data, encoding: .utf8)! == #"{"anyThing":1,"name":""}"#)
  }

  @Test func testEmpty() throws {
    let json1: JValue = nil
    #expect("null" == json1.debugDescription)
    let json2: JValue = [:]
    #expect("{}" == json2.debugDescription)
    let json3: JValue = []
    #expect("[]" == json3.debugDescription)
  }
}

class User: Codable {
  
  var anyThing: JValue = .null
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

extension JValue: CustomDebugStringConvertible {
  
  public var debugDescription: String {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.sortedKeys]
    do {
      let data = try encoder.encode(self)
      return String(data: data, encoding: .utf8) ?? ""
    } catch {
      return "encode to json string failed: \(error)"
    }
  }
}
