//
//  Movie.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: - Movie

class Movie: Object, Codable {
    @objc dynamic var popularity : Double = 0.0
    @objc dynamic var vote_count : Int = 0
    @objc dynamic var video : Bool = false
    @objc dynamic var poster_path : String? = nil
    @objc dynamic var id : Int = 0
    @objc dynamic var adult : Bool = false
    @objc dynamic var backdrop_path : String? = nil
    @objc dynamic var original_language : String? = nil
    @objc dynamic var original_title : String? = nil
    @objc dynamic var title : String? = nil
    @objc dynamic var vote_average : Double = 0
    @objc dynamic var overview : String? = nil
    @objc dynamic var release_date : String? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        
        case popularity = "popularity"
        case vote_count = "vote_count"
        case video = "video"
        case poster_path = "poster_path"
        case id = "id"
        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case original_language = "original_language"
        case original_title = "original_title"
        case title = "title"
        case vote_average = "vote_average"
        case overview = "overview"
        case release_date = "release_date"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        popularity = try values.decode(Double.self, forKey: .popularity)
        vote_count = try values.decode(Int.self, forKey: .vote_count)
        video = try values.decode(Bool.self, forKey: .video)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        id = try values.decode(Int.self, forKey: .id)
        adult = try values.decode(Bool.self, forKey: .adult)
        backdrop_path = try values.decode(String.self, forKey: .backdrop_path)
        original_language = try values.decode(String.self, forKey: .original_language)
        original_title = try values.decode(String.self, forKey: .original_title)
        title = try values.decode(String.self, forKey: .title)
        vote_average = try values.decode(Double.self, forKey: .vote_average)
        overview = try values.decode(String.self, forKey: .overview)
        release_date = try values.decode(String.self, forKey: .release_date)
    }
    
}


// MARK: - Movie (Resource) -

extension Movie {
    
    static func upcoming(page: Int) -> Resource<[Movie]> {
        let URL = TMDb.url(from: ["page": "\(page)"], withPathExtension: "/movie/upcoming")
        
        let resource = Resource<[Movie]>(url: URL) { json in
            let movies = (json as? JSONDictionary)?["results"] as? [JSONDictionary]
            return movies?.compactMap(Movie.init)
        }
        
        return resource
    }
    
    static func topRated(page: Int) -> Resource<[Movie]> {
        let URL = TMDb.url(from: ["page": "\(page)"], withPathExtension: "/movie/top_rated")
        
        let resource = Resource<[Movie]>(url: URL) { json in
            let movies = (json as? JSONDictionary)?["results"] as? [JSONDictionary]
            return movies?.compactMap(Movie.init)
        }
        
        return resource
    }
    
    static func search(query: String, page: Int) -> Resource<[Movie]> {
        let URL = TMDb.url(from: ["query": query, "page": "\(page)"], withPathExtension: "/search/movie")
        
        let resource = Resource<[Movie]>(url: URL) { json in
            let movies = (json as? JSONDictionary)?["results"] as? [JSONDictionary]
            return movies?.compactMap(Movie.init)
        }
        
        return resource
    }
    
}
