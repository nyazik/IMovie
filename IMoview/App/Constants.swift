//
//  Constants.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

struct Constants {
  
  // MARK: TMDB
  struct TMDB {
    static let ApiScheme = "https"
    static let ApiHost = "api.themoviedb.org"
    static let ApiPath = "/3"
  }
  
  // MARK: TMDB Parameter Keys
  struct TMDBParameterKeys {
    static let ApiKey = "api_key"
  }
  
  // MARK: TMDB Parameter Values
  struct TMDBParameterValues {
    static let ApiKey = "aa1464ab913485ca08a64fc7732e326c"
  }
  
  // MARK: TMDB Response Keys
  struct TMDBResponseKeys {
    static let Title = "title"
    static let ID = "id"
    static let PosterPath = "poster_path"
    static let StatusCode = "status_code"
    static let StatusMessage = "status_message"
    static let Success = "success"
    static let UserID = "id"
    static let Results = "results"
  }
  
}

