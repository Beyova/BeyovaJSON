//
//  JValuePerformanceTests.swift
//  BeyovaJSON
//
//  Created by Canius Chu on 2025/4/11.
//  Copyright © 2018 Beyova. All rights reserved.
//

import Foundation
import Testing
@testable import BeyovaJSON

@Suite("JValue Codable Performance Tests")
struct JValuePerformanceTests {
  
  let largeData: Data
  
  init() async throws {
    let url = "https://raw.githubusercontent.com/json-iterator/test-data/refs/heads/master/large-file.json"
    largeData = try Data(contentsOf: URL(string: url)!)
  }
  
  @Test func decodeLarge() throws {
    let date = Date()
    let decoder = JSONDecoder()
    _ = try decoder.decode(JValue.self, from: largeData)
    print("\(-date.timeIntervalSinceNow) ms elapsed")
  }
}
