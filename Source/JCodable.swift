//
//  JTokenCodable.swift
//  BeyovaJSON
//
//  Copyright © 2017 Beyova. All rights reserved.
//

import Foundation

extension JToken: Codable {
    
    public init(from decoder: Decoder) throws {
        if let keyed = try? decoder.container(keyedBy: JCodingKey.self) {
            self = try JToken.decode(from: keyed)
        }
        else if let unkeyed = try? decoder.unkeyedContainer() {
            self = try JToken.decode(from: unkeyed)
        }
        else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: ""))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null:
            try container.encodeNil()
        case let .simple(value):
            try container.encode(value)
        case let .object(value):
            try container.encode(value.item)
        case let .array(value):
            try container.encode(value.item)
        }
    }
    
    private static func decode(from container: KeyedDecodingContainer<JCodingKey>) throws -> JToken {
        var dict = [String:JToken]()
        for key in container.allKeys {
            if try container.decodeNil(forKey: key) {
                dict[key.stringValue] = .null
            }
            else if let keyed = try? container.nestedContainer(keyedBy: JCodingKey.self, forKey: key) {
                dict[key.stringValue] = try JToken.decode(from: keyed)
            }
            else if let unkeyed = try? container.nestedUnkeyedContainer(forKey: key) {
                dict[key.stringValue] = try JToken.decode(from: unkeyed)
            }
            else if let val = try? container.decode(JValue.self, forKey: key) {
                dict[key.stringValue] = .simple(val)
            }
            else {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: ""))
            }
        }
        return .object(.init(dict))
    }
    
    private static func decode(from container: UnkeyedDecodingContainer) throws -> JToken {
        var container = container
        var array = [JToken]()
        while !container.isAtEnd {
            if try container.decodeNil() {
                array.append(.null)
            }
            else if let keyed = try? container.nestedContainer(keyedBy: JCodingKey.self) {
                array.append(try JToken.decode(from: keyed))
            }
            else if let unkeyed = try? container.nestedUnkeyedContainer() {
                array.append(try JToken.decode(from: unkeyed))
            }
            else if let val = try? container.decode(JValue.self) {
                array.append(.simple(val))
            }
            else {
                throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: ""))
            }
        }
        return .array(.init(array))
    }
}

extension JValue: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self.init(value)
        }
        else if let value = try? container.decode(Bool.self) {
            self.init(value)
        }
        else if let value = try? container.decode(Int.self) {
            self.init(value)
        }
        else if let value = try? container.decode(Double.self) {
            self.init(value)
        }
        else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: ""))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch value {
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
            throw EncodingError.invalidValue(value, .init(codingPath: container.codingPath, debugDescription: ""))
        }
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
