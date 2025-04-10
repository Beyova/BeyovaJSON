//
//  JSON.swift
//  BeyovaJSON
//
//  Created by canius.chu on 22/2/2018.
//  Copyright © 2018 Beyova. All rights reserved.
//

import Foundation

public struct JSON {
  
  public private(set) var value: Any
  
  public init() {
    self.value = NSNull()
  }
  
  public init(_ value: Any?) {
    if let val = value {
      //TODO: check if jsonable
      self.value = val
    }
    else {
      self.value = NSNull()
    }
  }
}

