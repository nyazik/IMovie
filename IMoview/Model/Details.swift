// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let details = try? newJSONDecoder().decode(Details.self, from: jsonData)

import UIKit
import RealmSwift

// MARK: - Details
class Details: Object, Codable {
    @objc dynamic var adult : Bool = false
    @objc dynamic var backdrop_path : String? = nil
    @objc dynamic var belongs_to_collection : String? = nil
    @objc dynamic var budget : Int = 0
    @objc dynamic var homepage : String? = nil
    @objc dynamic var id : Int = 0
    @objc dynamic var imdb_id : String? = nil
    @objc dynamic var original_language : String? = nil
    @objc dynamic var original_title : String? = nil
    @objc dynamic var overview : String? = nil
    @objc dynamic var popularity : Double = 0
    @objc dynamic var poster_path : String? = nil
    @objc dynamic var release_date : String? = nil
    @objc dynamic var revenue : Int = 0
    @objc dynamic var runtime : Int = 0
    @objc dynamic var status : String? = nil
    @objc dynamic var tagline : String? = nil
    @objc dynamic var title : String? = nil
    @objc dynamic var video : Bool = false
    @objc dynamic var vote_average : Double = 0
    @objc dynamic var vote_count : Int = 0

    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {

        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case belongs_to_collection = "belongs_to_collection"
        case budget = "budget"
        case homepage = "homepage"
        case id = "id"
        case imdb_id = "imdb_id"
        case original_language = "original_language"
        case original_title = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case release_date = "release_date"
        case revenue = "revenue"
        case runtime = "runtime"
        case status = "status"
        case tagline = "tagline"
        case title = "title"
        case video = "video"
        case vote_average = "vote_average"
        case vote_count = "vote_count"
    }


    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decode(Bool.self, forKey: .adult)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        belongs_to_collection = try values.decodeIfPresent(String.self, forKey: .belongs_to_collection)
        budget = try values.decode(Int.self, forKey: .budget)
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
        id = try values.decode(Int.self, forKey: .id)
        imdb_id = try values.decodeIfPresent(String.self, forKey: .imdb_id)
        original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
        original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        popularity = try values.decode(Double.self, forKey: .popularity)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
        revenue = try values.decode(Int.self, forKey: .revenue)
        runtime = try values.decode(Int.self, forKey: .runtime)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        video = try values.decode(Bool.self, forKey: .video)
        vote_average = try values.decode(Double.self, forKey: .vote_average)
        vote_count = try values.decode(Int.self, forKey: .vote_count)
    }
    
   
}

extension Details {
    static func details(id: Int) -> Resource<Details> {
        let URL = TMDb.url(from: [:], withPathExtension: "/movie/\(id)")

        let resource = Resource<Details>(ofData: URL) { data in
            let jsonDecoder = JSONDecoder()
            let details = try? jsonDecoder.decode(Details.self, from: data as! Data)
            return details
        }

        return resource
    }
}
