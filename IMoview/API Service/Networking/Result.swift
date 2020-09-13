//
//  Result.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

enum Result<A> {
  case success(A)
  case error(Error)
}

extension Result {
  
  init(_ value: A?, or error: Error) {
    if let value = value {
      self = .success(value)
    } else {
      self = .error(error)
    }
  }
  
  var value: A? {
    guard case .success(let v) = self else { return nil }
    return v
  }
  
  var error: Error? {
    guard case .error(let e) = self else { return nil }
    return e
  }
  
}
