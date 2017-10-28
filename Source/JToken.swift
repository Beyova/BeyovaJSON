//
//  JToken.swift
//  BeyovaJSON
//
//  Copyright © 2017 Beyova. All rights reserved.
//

import Foundation

public enum JToken {
    case null
    case object(JContainer<[String: JToken]>)
    case array(JContainer<[JToken]>)
    case simple(JValue)
}
