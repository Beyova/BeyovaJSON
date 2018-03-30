//
//  JCodable.swift
//  BeyovaJSON
//
//  Copyright © 2018 Beyova. All rights reserved.
//

import Foundation

extension JSON: Codable {
    
    public init(from decoder: Decoder) throws {
        if let keyed = try? decoder.container(keyedBy: JCodingKey.self) {
            self.init(try JSON.decode(from: keyed))
        }
        else if let unkeyed = try? decoder.unkeyedContainer() {
            self.init(try JSON.decode(from: unkeyed))
        }
        else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: ""))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        
        if try JSON.encode(simple: self.value, from: encoder.singleValueContainer()) {
            return
        }
        
        switch self.value {
        case let val as [String:Any]:
            try JSON.encode(dict: val, from: encoder.container(keyedBy: JCodingKey.self))
        case let val as [Any]:
            try JSON.encode(array: val, from: encoder.unkeyedContainer())
        default:
            throw EncodingError.invalidValue(self.value, .init(codingPath: encoder.codingPath, debugDescription: ""))
        }
    }
    
    private static func encode(dict: [String:Any], from container: KeyedEncodingContainer<JCodingKey>) throws {
        var container = container
        for (k,v) in dict {
            let key = JCodingKey.init(stringValue: k)!
            switch v {
            case let val as [String:Any]:
                try JSON.encode(dict: val, from: container.nestedContainer(keyedBy: JCodingKey.self, forKey: key))
            case let val as [Any]:
                try JSON.encode(array: val, from: container.nestedUnkeyedContainer(forKey: key))
            case let val as String:
                try container.encode(val, forKey: key)
            case let val as Int:
                try container.encode(val, forKey: key)
            case let val as Bool:
                try container.encode(val, forKey: key)
            case let val as Date:
                try container.encode(val, forKey: key)
            case let val as Data:
                try container.encode(val, forKey: key)
            case let val as Float:
                try container.encode(val, forKey: key)
            case let val as Double:
                try container.encode(val, forKey: key)
            case let val as Decimal:
                try container.encode(val, forKey: key)
            case let val as Int8:
                try container.encode(val, forKey: key)
            case let val as Int16:
                try container.encode(val, forKey: key)
            case let val as Int32:
                try container.encode(val, forKey: key)
            case let val as Int64:
                try container.encode(val, forKey: key)
            case let val as UInt8:
                try container.encode(val, forKey: key)
            case let val as UInt16:
                try container.encode(val, forKey: key)
            case let val as UInt32:
                try container.encode(val, forKey: key)
            case let val as UInt64:
                try container.encode(val, forKey: key)
            case is NSNull:
                try container.encodeNil(forKey: key)
            default:
                throw EncodingError.invalidValue(v, .init(codingPath: container.codingPath, debugDescription: ""))
            }
        }
    }
    
    private static func encode(array: [Any], from container: UnkeyedEncodingContainer) throws {
        var container = container
        for v in array {
            switch v {
            case let val as [String:Any]:
                try JSON.encode(dict: val, from: container.nestedContainer(keyedBy: JCodingKey.self))
            case let val as [Any]:
                try JSON.encode(array: val, from: container.nestedUnkeyedContainer())
            case let val as String:
                try container.encode(val)
            case let val as Int:
                try container.encode(val)
            case let val as Bool:
                try container.encode(val)
            case let val as Date:
                try container.encode(val)
            case let val as Data:
                try container.encode(val)
            case let val as Float:
                try container.encode(val)
            case let val as Double:
                try container.encode(val)
            case let val as Decimal:
                try container.encode(val)
            case let val as Int8:
                try container.encode(val)
            case let val as Int16:
                try container.encode(val)
            case let val as Int32:
                try container.encode(val)
            case let val as Int64:
                try container.encode(val)
            case let val as UInt8:
                try container.encode(val)
            case let val as UInt16:
                try container.encode(val)
            case let val as UInt32:
                try container.encode(val)
            case let val as UInt64:
                try container.encode(val)
            case is NSNull:
                try container.encodeNil()
            default:
                throw EncodingError.invalidValue(v, .init(codingPath: container.codingPath, debugDescription: ""))
            }
        }
    }
    
    private static func encode(simple: Any, from container: SingleValueEncodingContainer) throws -> Bool  {
        var container = container
        switch simple {
        case is NSNull:
            try container.encodeNil()
        case let val as String:
            try container.encode(val)
        case let val as Int:
            try container.encode(val)
        case let val as Bool:
            try container.encode(val)
        case let val as Date:
            try container.encode(val)
        case let val as Data:
            try container.encode(val)
        case let val as Float:
            try container.encode(val)
        case let val as Double:
            try container.encode(val)
        case let val as Decimal:
            try container.encode(val)
        case let val as Int8:
            try container.encode(val)
        case let val as Int16:
            try container.encode(val)
        case let val as Int32:
            try container.encode(val)
        case let val as Int64:
            try container.encode(val)
        case let val as UInt8:
            try container.encode(val)
        case let val as UInt16:
            try container.encode(val)
        case let val as UInt32:
            try container.encode(val)
        case let val as UInt64:
            try container.encode(val)
        default:
            return false
        }
        return true
    }
    
    private static func decode(from container: KeyedDecodingContainer<JCodingKey>) throws -> [String:Any] {
        var dict = [String:Any]()
        for key in container.allKeys {
            if try container.decodeNil(forKey: key) {
                dict[key.stringValue] = NSNull()
            }
            else if let keyed = try? container.nestedContainer(keyedBy: JCodingKey.self, forKey: key) {
                dict[key.stringValue] = try JSON.decode(from: keyed)
            }
            else if let unkeyed = try? container.nestedUnkeyedContainer(forKey: key) {
                dict[key.stringValue] = try JSON.decode(from: unkeyed)
            }
            else if let val = try? container.decode(String.self, forKey: key) {
                dict[key.stringValue] = val
            }
            else if let val = try? container.decode(Bool.self, forKey: key) {
                dict[key.stringValue] = val
            }
            else if let val = try? container.decode(Int64.self, forKey: key) {
                dict[key.stringValue] = val
            }
            else if let val = try? container.decode(Double.self, forKey: key) {
                dict[key.stringValue] = val
            }
            else {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: ""))
            }
        }
        return dict
    }
    
    private static func decode(from container: UnkeyedDecodingContainer) throws -> [Any] {
        var container = container
        var array = [Any]()
        while !container.isAtEnd {
            if try container.decodeNil() {
                array.append(NSNull())
            }
            else if let keyed = try? container.nestedContainer(keyedBy: JCodingKey.self) {
                array.append(try JSON.decode(from: keyed))
            }
            else if let unkeyed = try? container.nestedUnkeyedContainer() {
                array.append(try JSON.decode(from: unkeyed))
            }
            else if let val = try? container.decode(String.self) {
                array.append(val)
            }
            else if let val = try? container.decode(Bool.self) {
                array.append(val)
            }
            else if let val = try? container.decode(Int64.self) {
                array.append(val)
            }
            else if let val = try? container.decode(Double.self) {
                array.append(val)
            }
            else {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: ""))
            }
        }
        return array
    }
}

class JCodingKey: CodingKey {
    
    var stringValue: String
    
    required init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    required init?(intValue: Int) {
        self.intValue = intValue
        stringValue = ""
    }
}
