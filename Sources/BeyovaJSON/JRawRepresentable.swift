//
//  JRawRepresentable.swift
//  BeyovaJSON
//
//  Created by canius.chu on 22/2/2018.
//  Copyright © 2018 Beyova. All rights reserved.
//

import Foundation

extension JSON: RawRepresentable {
  
  public init?(rawValue: Data) {
    do {
      let decoder = JSONDecoder()
      self = try decoder.decode(JSON.self, from: rawValue)
    } catch let error {
      print(error)
      return nil
    }
  }
  
  public var rawValue: Data {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .sortedKeys
      return try encoder.encode(self)
    } catch let error {
      fatalError("\(error)")
    }
  }
}

extension JSON: CustomStringConvertible {
  
  public var description: String {
    var ret: String? = nil
    let encoder = JSONEncoder()
    encoder.outputFormatting = .sortedKeys
    if let data = try? encoder.encode(self) {
      ret = String(data: data, encoding: .utf8)
    }
    return ret ?? "<<error>>"
  }
}
