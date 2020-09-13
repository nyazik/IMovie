//
//  TMDb+ResourceExtensions.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

extension TMDbConfig {
  
  class func resource() -> Resource<TMDbConfig> {
    let URL = TMDb.url(from: [:], withPathExtension: "/configuration")
    let resource = Resource<TMDbConfig>(url: URL) { json in
      let dictionary = json as? JSONDictionary
      return dictionary.flatMap(TMDbConfig.init)
    }
    
    return resource
  }
  
}
