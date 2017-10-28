//
//  JComparable.swift
//  BeyovaJSON
//
//  Copyright © 2017 Beyova. All rights reserved.
//

import Foundation

extension JToken: Comparable {
    
    public static func <(lhs: JToken, rhs: JToken) -> Bool {
        switch (lhs,rhs) {
        case (.null,.null):
            return false
        case (.simple(let lval),.simple(let rval)):
            return lval < rval
        default:
            fatalError("'>' and '<' cannot be applied, wrong types")
        }
    }
    
    public static func ==(lhs: JToken, rhs: JToken) -> Bool {
        switch (lhs,rhs) {
        case (.null,.null):
            return true
        case (.simple(let lval),.simple(let rval)):
            return lval == rval
        case (.array,.array):
            return lhs.rawValue as! NSArray == rhs.rawValue as! NSArray
        case (.object,.object):
            return lhs.rawValue as! NSDictionary == rhs.rawValue as! NSDictionary
        default:
            return false
        }
    }
}

extension JValue: Comparable {
    
    public static func <(lhs: JValue, rhs: JValue) -> Bool {
        switch (lhs.value,rhs.value) {
        case (_ as Bool, _ as Bool):
            fatalError("'>' and '<' cannot be applied to two 'Bool' operands")
        case (_ as Data, _ as Data):
            fatalError("'>' and '<' cannot be applied to two 'Data' operands")
        case (let lval as String, let rval as String):
            return lval < rval
        case (let lval as Date, let rval as Date):
            return lval < rval
        case (let lval as NSNumber, let rval as NSNumber):
            return lval.compare(rval) == .orderedAscending
        default:
            fatalError("'>' and '<' cannot be applied, wrong types")
        }
    }
    
    public static func ==(lhs: JValue, rhs: JValue) -> Bool {
        switch (lhs.value,rhs.value) {
        case (let lval as Bool, let rval as Bool):
            return lval == rval
        case (let lval as Data, let rval as Data):
            return lval == rval
        case (let lval as String, let rval as String):
            return lval == rval
        case (let lval as Date, let rval as Date):
            return lval == rval
        case (let lval as NSNumber, let rval as NSNumber):
            return lval.compare(rval) == .orderedSame
        default:
            fatalError("'>' and '<' cannot be applied, wrong types")
        }
    }
}

