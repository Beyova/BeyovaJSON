//
//  JExpressible.swift
//  BeyovaJSON
//
//  Copyright © 2017 Beyova. All rights reserved.
//

import Foundation

extension JToken: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: StringLiteralType) {
        self = .simple(.init(value))
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self = .simple(.init(value))
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self = .simple(.init(value))
    }
}

extension JToken: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        self = .simple(.init(value))
    }
}

extension JToken: Swift.ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: FloatLiteralType) {
        self = .simple(.init(value))
    }
}

extension JToken: ExpressibleByBooleanLiteral {
    
    public init(booleanLiteral value: Bool) {
        self = .simple(.init(value))
    }
}

extension JToken: ExpressibleByDictionaryLiteral {
    
    public init(dictionaryLiteral elements: (String, Any)...) {
        self.init(elements)
    }
}

extension JToken: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Any...) {
        self.init(elements)
    }
}

