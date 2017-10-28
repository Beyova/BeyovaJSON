//
//  JContainer.swift
//  BeyovaJSON
//
//  Copyright © 2017 Beyova. All rights reserved.
//

import Foundation

public class JContainer<T> {
    
    public var item: T
    
    init(_ item: T) {
        self.item = item
    }
}

extension JToken {
    
    public mutating func append(_ item: JToken) {
        switch self {
        case .array(let value):
            value.item.append(item)
        default:
            fatalError()
        }
    }
    
    public mutating func append(_ item: Any) {
        self.append(.init(item))
    }
    
    public subscript (propertyName: String) -> JToken {
        get {
            switch self {
            case .object(let value):
                return value.item[propertyName] ?? .null
            case .null:
                return .null
            default:
                fatalError("It is an unsupported type")
            }
        }
        set {
            switch self {
            case .object(let value):
                value.item[propertyName] = newValue
            case .null:
                return
            default:
                fatalError("It is an unsupported type")
            }
        }
    }
    
    public subscript (index: Int) -> JToken {
        get {
            switch self {
            case .array(let value):
                return value.item[index]
            default:
                fatalError("It is an unsupported type")
            }
        }
        set {
            switch self {
            case .array(let value):
                value.item[index] = newValue
            case .null:
                return
            default:
                fatalError("It is an unsupported type")
            }
        }
    }
}

public enum JIndex<T>: Comparable {
    
    case array(Int)
    case dictionary(DictionaryIndex<String, T>)
    
    static public func == (lhs: JIndex, rhs: JIndex) -> Bool {
        switch (lhs, rhs) {
        case (.array(let left), .array(let right)):
            return left == right
        case (.dictionary(let left), .dictionary(let right)):
            return left == right
        default:
            return false
        }
    }
    
    static public func < (lhs: JIndex, rhs: JIndex) -> Bool {
        switch (lhs, rhs) {
        case (.array(let left), .array(let right)):
            return left < right
        case (.dictionary(let left), .dictionary(let right)):
            return left < right
        default:
            return false
        }
    }
}

extension JToken: Collection {
    
    public typealias Index = JIndex<JToken>
    
    public var startIndex: Index {
        switch self {
        case .array(let value):
            return .array(value.item.startIndex)
        case .object(let value):
            return .dictionary(value.item.startIndex)
        default:
            fatalError()
        }
    }
    
    public var endIndex: Index {
        switch self {
        case .array(let value):
            return .array(value.item.endIndex)
        case .object(let value):
            return .dictionary(value.item.endIndex)
        default:
            fatalError()
        }
    }
    
    public func index(after i: Index) -> Index {
        switch (self,i) {
        case (.array(let value), .array(let idx)):
            return .array(value.item.index(after: idx))
        case (.object(let value), .dictionary(let idx)):
            return .dictionary(value.item.index(after: idx))
        default:
            fatalError()
        }
    }
    
    public subscript(position: Index) -> (key: String, value: JToken) {
        switch (self,position) {
        case (.array(let value), .array(let idx)):
            return (String(idx), value.item[idx])
        case (.object(let value), .dictionary(let idx)):
            return value.item[idx]
        default:
            fatalError()
        }
    }
}
