//
//  Resource.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

struct Resource<A> {
    var url: URL
    var parse: (Data) -> A?
}

extension Resource {
    init(url: URL, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            return json.flatMap(parseJSON)
        }
    }
    
    init(ofData: URL, parseJSON: @escaping (Any) -> A?) {
        self.url = ofData
        self.parse = { data in
            return parseJSON(data)
        }
    }
    
}
