//
//  Webservice.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

enum WebserviceError: Error {
  case other
}

final class Webservice {
  init() { }
  
  /// Loads a resource. The completion handler is always called on the main queue.
  func load<A>(_ resource: Resource<A>, completion: @escaping (Result<A>) -> ()) {
    URLSession.shared.dataTask(with: resource.url, completionHandler: { data, response, _ in
      let parsed = data.flatMap(resource.parse)
      let result = Result(parsed, or: WebserviceError.other)
      mainQueue { completion(result) }
    }) .resume()
  }
}

public func mainQueue(_ block: @escaping () -> ()) {
  DispatchQueue.main.async(execute: block)
}
