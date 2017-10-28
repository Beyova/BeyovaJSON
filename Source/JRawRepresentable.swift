//
//  JRawRepresentable.swift
//  BeyovaJSON
//
//  Copyright © 2017 Beyova. All rights reserved.
//

import Foundation

extension JToken: RawRepresentable {
    
    public init?(rawValue: Any) {
        self = JToken.init(rawValue)
    }
    
    public var rawValue: Any {
        switch self {
        case .null:
            return NSNull()
        case .simple(let val):
            return val.value
        case .array(let val):
            return val.item.map({$0.rawValue})
        case .object(let val):
            return val.item.mapValues({$0.rawValue})
        }
    }
}

extension JToken {
    
    public init(_ value: Any?) {
        
        guard let value = value else {
            self = .null
            return
        }
        
        switch value {
        case let val as JToken:
            self = val
        case let val as JValue:
            self = .simple(val)
        case let val as [String: JToken]:
            self = .init(val)
        case let val as [JToken]:
            self = .init(val)
        case let val as [String: Any]:
            self = .init(val)
        case let val as [Any]:
            self = .init(val)
        default:
            self = .simple(JValue(value))
        }
    }
    
    public init(_ value: [JToken]) {
        self = .array(.init(value))
    }
    
    public init(_ value: [Any]) {
        self = .array(.init(value.map(JToken.init)))
    }
    
    public init(_ value: [String: JToken]) {
        self = .object(.init(value))
    }
    
    public init(_ value: [String: Any]) {
        self = .object(.init(value.mapValues(JToken.init)))
    }
    
    internal init(_ value: [(String, JToken)]) {
        var dic: Dictionary<String,JToken> = [:]
        for (k,v) in value {
            dic[k] = v
        }
        self = .object(.init(dic))
    }
    
    internal init(_ value: [(String, Any)]) {
        self = .init(value.map({($0,JToken($1))}))
    }
}

extension JToken {
    
    public static let encoder = JSONEncoder()
    
    public static let decoder = JSONDecoder()
    
    public init(rawData: Data) throws {
        self = try JToken.decoder.decode(JToken.self, from: rawData)
    }
    
    public func rawData(formatting: JSONEncoder.OutputFormatting = []) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = formatting
        encoder.dateEncodingStrategy = JToken.encoder.dateEncodingStrategy
        return try encoder.encode(self)
    }
}

extension JToken: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .null:
            return "null"
        case .simple(let value):
            return value.description
        default:
            if let data = try? self.rawData(formatting: .prettyPrinted) {
                return String(bytes: data, encoding: .utf8) ?? "<<error>>"
            }
            return "<<error>>"
        }
    }
}
