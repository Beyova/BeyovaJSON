//
//  JExpressible.swift
//  BeyovaJSON
//
//  Copyright © 2018 Beyova. All rights reserved.
//

import Foundation

extension JSON: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self.init(value)
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self.init(value)
    }
}

extension JSON: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        self.init(value)
    }
}

extension JSON: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: FloatLiteralType) {
        self.init(value)
    }
}

extension JSON: ExpressibleByBooleanLiteral {
    
    public init(booleanLiteral value: Bool) {
        self.init(value)
    }
}

extension JSON: ExpressibleByDictionaryLiteral {
    
    public init(dictionaryLiteral elements: (String, Any)...) {
        var dict = [String:Any]()
        for (k,v) in elements {
            dict[k] = v
        }
        self.init(dict)
    }
}

extension JSON: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Any...) {
        self.init(elements)
    }
}

