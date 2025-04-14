//
//  JValue.swift
//  BeyovaJSON
//
//  Created by Canius Chu on 2025/4/11.
//  Copyright © 2018 Beyova. All rights reserved.
//

import Foundation

public indirect enum JValue: Equatable {
  
  case null
  case string(String)
  case boolean(Bool)
  case integer(Int)
  case float(Double)
  case array([JValue])
  case object([String: JValue])
}

extension JValue: Codable {
  
  public func encode(to encoder: any Encoder) throws {
    switch self {
    case .null:
      var container = encoder.singleValueContainer()
      try container.encodeNil()
    case .string(let val):
      var container = encoder.singleValueContainer()
      try container.encode(val)
    case .boolean(let val):
      var container = encoder.singleValueContainer()
      try container.encode(val)
    case .integer(let val):
      var container = encoder.singleValueContainer()
      try container.encode(val)
    case .float(let val):
      var container = encoder.singleValueContainer()
      try container.encode(val)
    case .array(let array):
      var container = encoder.unkeyedContainer()
      try container.encode(contentsOf: array)
    case .object(let dict):
      var container = encoder.container(keyedBy: CodingKeys.self)
      for (key, val) in dict {
        try container.encode(val, forKey: .init(stringValue: key)!)
      }
    }
  }
  
  public init(from decoder: any Decoder) throws {
    if let keyed = try? decoder.container(keyedBy: CodingKeys.self) {
      var dict = [String: JValue]()
      for key in keyed.allKeys {
        dict[key.stringValue] = try keyed.decode(JValue.self, forKey: key)
      }
      self = .object(dict)
    } else if var unkeyed = try? decoder.unkeyedContainer() {
      var array = [JValue]()
      while !unkeyed.isAtEnd {
        array.append(try unkeyed.decode(JValue.self))
      }
      self = .array(array)
    } else if let single = try? decoder.singleValueContainer() {
      if single.decodeNil() {
        self = .null
      } else if let val = try? single.decode(String.self) {
        self = .string(val)
      } else if let val = try? single.decode(Int.self) {
        self = .integer(val)
      } else if let val = try? single.decode(Double.self) {
        self = .float(val)
      } else if let val = try? single.decode(Bool.self) {
        self = .boolean(val)
      } else {
        throw DecodingError.dataCorrupted(.init(codingPath: single.codingPath, debugDescription: "decode single container failed"))
      }
    }  else {
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "decode container not found"))
    }
  }
  
  struct CodingKeys: CodingKey {
    
    var stringValue: String
    
    init?(stringValue: String) {
      self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    init?(intValue: Int) {
      self.intValue = intValue
      stringValue = ""
    }
  }
}

extension JValue: ExpressibleByNilLiteral {
  
  public init(nilLiteral: ()) {
    self = .null
  }
}

extension JValue: ExpressibleByStringLiteral {
  
  public init(stringLiteral value: StringLiteralType) {
    self = .string(value)
  }
  
  public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
    self = .string(value)
  }
  
  public init(unicodeScalarLiteral value: StringLiteralType) {
    self = .string(value)
  }
}

extension JValue: ExpressibleByIntegerLiteral {
  
  public init(integerLiteral value: Int) {
    self = .integer(value)
  }
}

extension JValue: ExpressibleByFloatLiteral {
  
  public init(floatLiteral value: FloatLiteralType) {
    self = .float(value)
  }
}

extension JValue: ExpressibleByBooleanLiteral {
  
  public init(booleanLiteral value: Bool) {
    self = .boolean(value)
  }
}

extension JValue: ExpressibleByDictionaryLiteral {
  
  public init(dictionaryLiteral elements: (String, JValue)...) {
    var dict = [String: JValue]()
    for (k,v) in elements {
      dict[k] = v
    }
    self = .object(dict)
  }
}

extension JValue: ExpressibleByArrayLiteral {
  
  public init(arrayLiteral elements: JValue...) {
    self = .array(elements)
  }
}
