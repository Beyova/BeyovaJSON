//
//  JValue.swift
//  BeyovaJSON
//
//  Copyright © 2017 Beyova. All rights reserved.
//

import Foundation

public struct JValue {
    
    private var _value: Any
    
    public var value: Any {
        return _value
    }
    
    public init(_ value: JConvertable) {
        _value = value
    }
    
    public init(_ value: Bool) {
        _value = value
    }
    
    public init(_ value: Date) {
        _value = value
    }
    
    public init(_ value: Data) {
        _value = value
    }
    
    public init(_ value: Any) {
        switch value {
        case let val as JConvertable:
            _value = val
        case let val as Date:
            _value = val
        case let val as Data:
            _value = val
        case let val as Bool:
            _value = val
        case let val as JValue:
            _value = val._value
        default:
            let message = String(format: "It is an unsupported type: %@ value: %@", String(reflecting: type(of: value)), String(describing: value))
            fatalError(message)
        }
    }
    
    public var convertable: JConvertable {
        guard let val = _value as? JConvertable else {
            fatalError(fatalMessage("JConvertable"))
        }
        return val
    }
    
    public var dateValue: Date {
        guard let val = _value as? Date else {
            fatalError(fatalMessage("Date"))
        }
        return val
    }
    
    public var bytesValue: Data {
        if let val = _value as? String, let data = Data(base64Encoded: val) {
            return data
        }
        guard let val = _value as? Data else {
            fatalError(fatalMessage("Data"))
        }
        return val
    }
    
    public var boolValue: Bool {
        if let val = _value as? Bool {
            return val
        }
        if let val = _value as? JConvertable {
            let s: String = val.convert()
            return ["true", "y", "t", "yes", "1"].contains { s.caseInsensitiveCompare($0) == .orderedSame }
        }
        fatalError(fatalMessage("Bool"))
    }
    
    private func fatalMessage(_ destinationTypeName: String) -> String {
        return String(format: "Failed to convert to %@. It is an unsupported type: %@ value: %@",destinationTypeName, String(reflecting: type(of: _value)), String(describing: _value))
    }
}

extension JValue: CustomStringConvertible {
    
    public var description: String {
        if let val = value as? CustomStringConvertible {
            return val.description
        }
        return "<<error type>>"
    }
}

extension JToken {
    
// MARK: - Optional
    
    public var bool: Bool? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.boolValue
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var date: Date? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.dateValue
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var bytes: Data? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.bytesValue
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var string: String? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var float: Float? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var double: Double? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var decimal: Decimal? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var int: Int? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var int8: Int8? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var int16: Int16? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var int32: Int32? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var int64: Int64? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var uint: UInt? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var uint8: UInt8? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var uint16: UInt16? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var uint32: UInt32? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
    public var uint64: UInt64? {
        switch self {
        case .null:
            return nil
        case .simple(let value):
            return value.convertable.convert()
        default:
            fatalError("It is an unsupported type")
        }
    }
    
// MARK: - Required
    
    public var boolValue: Bool {
        guard let val = self.bool else {
            return .init()
        }
        return val
    }
    
    public var dateValue: Date {
        guard let val = self.date else {
            return .init()
        }
        return val
    }
    
    public var bytesValue: Data {
        guard let val = self.bytes else {
            return .init()
        }
        return val
    }
    
    public var stringValue: String {
        guard let val = self.string else {
            return .init()
        }
        return val
    }
    
    public var floatValue: Float? {
        guard let val = self.float else {
            return .init()
        }
        return val
    }
    
    public var doubleValue: Double? {
        guard let val = self.double else {
            return .init()
        }
        return val
    }
    
    public var decimalValue: Decimal? {
        guard let val = self.decimal else {
            return .init()
        }
        return val
    }
    
    public var intValue: Int {
        guard let val = self.int else {
            return .init()
        }
        return val
    }
    
    public var int8Value: Int8 {
        guard let val = self.int8 else {
            return .init()
        }
        return val
    }
    
    public var int16Value: Int16? {
        guard let val = self.int16 else {
            return .init()
        }
        return val
    }
    
    public var int32Value: Int32? {
        guard let val = self.int32 else {
            return .init()
        }
        return val
    }
    
    public var int64Value: Int64? {
        guard let val = self.int64 else {
            return .init()
        }
        return val
    }
    
    public var uintValue: UInt? {
        guard let val = self.uint else {
            return .init()
        }
        return val
    }
    
    public var uint8Value: UInt8? {
        guard let val = self.uint8 else {
            return .init()
        }
        return val
    }
    
    public var uint16Value: UInt16? {
        guard let val = self.uint16 else {
            return .init()
        }
        return val
    }
    
    public var uint32Value: UInt32? {
        guard let val = self.uint32 else {
            return .init()
        }
        return val
    }
    
    public var uint64Value: UInt64? {
        guard let val = self.uint64 else {
            return .init()
        }
        return val
    }
}
