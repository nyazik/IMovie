//
//  TMDbConfig.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import Foundation

// MARK: File Support

private let _documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
private let _fileURL = _documentsDirectoryURL.appendingPathComponent("TheMovieDB-Configuration")

// MARK: - TMDbConfig -

///  The TMDbConfig stores (persist) information that is used to build image
///  URL's for TheMovieDB. Invoking the updateConfig convenience method
///  will download the latest using the initializer below to parse the dictionary.
class TMDbConfig: NSObject, NSCoding {
  
  // MARK: Properties
  
  // default values from 13/07/16
  var baseImageURLString = "http://image.tmdb.org/t/p/"
  var secureBaseImageURLString =  "https://image.tmdb.org/t/p/"
  var posterSizes = ["w92", "w154", "w185", "w342", "w500", "w780", "original"]
  var dateUpdated: Date? = nil
  
  /// Returns the number days since the config was last updated.
  var daysSinceLastUpdate: Int? {
    if let lastUpdate = dateUpdated {
      return Int(Date().timeIntervalSince(lastUpdate)) / (60 * 60 * 24)
    } else {
      return nil
    }
  }
  
  // MARK: Initialization
  
  override init() {}
  
  convenience init?(dictionary: [String: AnyObject]) {
    self.init()
    
    guard let imageDictionary = dictionary["images"] as? [String: AnyObject],
      let urlString = imageDictionary["base_url"] as? String,
      let secureURLString = imageDictionary["secure_base_url"] as? String,
      let posterSizesArray = imageDictionary["poster_sizes"] as? [String] else {
        return nil
    }
    
    self.baseImageURLString = urlString
    self.secureBaseImageURLString = secureURLString
    self.posterSizes = posterSizesArray
    self.dateUpdated = Date()
  }
  
  // MARK: Update
  
  func requestForNewConfigIfDaysSinceUpdateExceeds(_ days: Int, newConfig completion: @escaping (Result<TMDbConfig>) -> ()) {
    guard let daysSinceLastUpdate = daysSinceLastUpdate, daysSinceLastUpdate <= days else {
      return Webservice().load(TMDbConfig.resource(), completion: completion)
    }
  }
  
  // MARK: NSCoding
  
  private enum CodingKeys: String {
    case baseImageUrl
    case secureBaseImageUrl
    case posterSizes
    case dateUpdated
  }
  
  required init(coder aDecoder: NSCoder) {
    baseImageURLString = aDecoder.decodeObject(forKey: CodingKeys.baseImageUrl.rawValue) as! String
    secureBaseImageURLString = aDecoder.decodeObject(forKey: CodingKeys.secureBaseImageUrl.rawValue) as! String
    posterSizes = aDecoder.decodeObject(forKey: CodingKeys.posterSizes.rawValue) as! [String]
    dateUpdated = aDecoder.decodeObject(forKey: CodingKeys.dateUpdated.rawValue) as? Date
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(baseImageURLString, forKey: CodingKeys.baseImageUrl.rawValue)
    aCoder.encode(secureBaseImageURLString, forKey: CodingKeys.secureBaseImageUrl.rawValue)
    aCoder.encode(posterSizes, forKey: CodingKeys.posterSizes.rawValue)
    aCoder.encode(dateUpdated, forKey: CodingKeys.dateUpdated.rawValue)
  }
  
  func save() {
    NSKeyedArchiver.archiveRootObject(self, toFile: _fileURL.path)
  }
  
  class func unarchivedInstance() -> TMDbConfig? {
    if FileManager.default.fileExists(atPath: _fileURL.path) {
      return NSKeyedUnarchiver.unarchiveObject(withFile: _fileURL.path) as? TMDbConfig
    } else {
      return nil
    }
  }
  
}
