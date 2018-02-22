//
//  JRawRepresentable.swift
//  BeyovaJSON
//
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
            return try encoder.encode(self)
        } catch let error {
            fatalError("\(error)")
        }
    }
}
