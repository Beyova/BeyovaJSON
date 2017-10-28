//
//  JConvertable.swift
//  BeyovaJSON
//
//  Copyright © 2017 Beyova. All rights reserved.
//

import Foundation

public protocol JConvertable {
    
    func convert<T:JConvertable>() -> T
    
    init()
    init?(_ value: String)
    init(_ value: Decimal)
    init(_ value: Float)
    init(_ value: Double)
    init(_ value: Int)
    init(_ value: Int8)
    init(_ value: Int16)
    init(_ value: Int32)
    init(_ value: Int64)
    init(_ value: UInt)
    init(_ value: UInt8)
    init(_ value: UInt16)
    init(_ value: UInt32)
    init(_ value: UInt64)
}

extension String: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self) ?? T.init()
    }
    public init?(_ value: String) {
        self = value
    }
    public init(_ value: Decimal) {
        var val = value
        self = NSDecimalString(&val, nil)
    }
}

extension Decimal: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init?(_ value: String) {
        guard let val = Decimal(string: value, locale: nil) else { return nil }
        self = val
    }
    public init(_ value: Decimal) {
        self = value
    }
    public init(_ value: Float) {
        self = .init(Double(value))
    }
}

extension Float: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = (value as NSDecimalNumber).floatValue
    }
}

extension Double: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = (value as NSDecimalNumber).doubleValue
    }
}

extension Int: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = .init(Double(value))
    }
}

extension Int8: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = .init(Double(value))
    }
}

extension Int16: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = .init(Double(value))
    }
}

extension Int32: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = .init(Double(value))
    }
}

extension Int64: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = .init(Double(value))
    }
}

extension UInt: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = .init(Double(value))
    }
}

extension UInt8: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = .init(Double(value))
    }
}

extension UInt16: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = .init(Double(value))
    }
}

extension UInt32: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = .init(Double(value))
    }
}

extension UInt64: JConvertable {
    public func convert<T>() -> T where T : JConvertable {
        return T.init(self)
    }
    public init(_ value: Decimal) {
        self = .init(Double(value))
    }
}
