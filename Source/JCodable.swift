//
//  JTokenCodable.swift
//  BeyovaJSON
//
//  Copyright © 2017 Beyova. All rights reserved.
//

import Foundation

extension JToken: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
        }
        else if let array = try? container.decode([JToken].self) {
            self = .array(.init(array))
        }
        else if let dict = try? container.decode([String: JToken].self) {
            self = .object(.init(dict))
        }
        else if let val = try? container.decode(JValue.self) {
            self = .simple(val)
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
}

extension JValue: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(Date.self) {
            self.init(value)
        }
        else if let value = try? container.decode(String.self) {
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
