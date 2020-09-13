//
//  TMDb.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import Foundation

typealias MethodParameters = [String: Any]
typealias MoviesCompletionHandler = ([Movie]?, Error?) -> Void
typealias DetailsCompletionHandler = (Details?, Error?) -> Void

// MARK: TMDb

class TMDb {
    
    // MARK: Properties
    
    var webservice: Webservice
    var config: TMDbConfig
    
    // MARK: Init
    
    init(webservice: Webservice, config: TMDbConfig) {
        self.webservice = webservice
        self.config = config
        
        config.requestForNewConfigIfDaysSinceUpdateExceeds(7) { [unowned self] result in
            guard let newConfig = result.value else { return print(result.error!) }
            self.config = newConfig
            self.config.save()
        }
    }
    
    convenience init(webservice: Webservice) {
        let config = TMDbConfig.unarchivedInstance() ?? TMDbConfig()
        self.init(webservice: webservice, config: config)
    }
    
}

// MARK: - Create URLs -

extension TMDb {
    
    class func url(from parameters: MethodParameters, withPathExtension: String? = nil) -> URL {
        var components = URLComponents()
        components.scheme = Constants.TMDB.ApiScheme
        components.host = Constants.TMDB.ApiHost
        components.path = Constants.TMDB.ApiPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        let apiKey = URLQueryItem(
            name: Constants.TMDBParameterKeys.ApiKey,
            value: Constants.TMDBParameterValues.ApiKey
        )
        components.queryItems!.append(apiKey)
        
        parameters.forEach { key, value in
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
}

// MARK: - Calling Endpoints -

extension TMDb {
    
    func upcomingMovies(page: Int = 1, _ completion: @escaping MoviesCompletionHandler) {
        webservice.load(Movie.upcoming(page: page)) { result in
            guard let movies = result.value else { return completion(nil, result.error) }
            completion(movies, nil)
        }
    }
    
    func topRatedMovies(page: Int = 1, _ completion: @escaping MoviesCompletionHandler) {
        webservice.load(Movie.topRated(page: page)) { result in
            guard let movies = result.value else { return completion(nil, result.error) }
            completion(movies, nil)
        }
    }
    
    func searchMovie(query: String, page: Int = 1, _ completion: @escaping MoviesCompletionHandler) {
        webservice.load(Movie.search(query: query, page: page)) { result in
            guard let movies = result.value else { return completion(nil, result.error) }
            completion(movies, nil)
        }
    }
    
    func movieDetails(id: Int, _ completion: @escaping DetailsCompletionHandler) {
        webservice.load(Details.details(id: id)) { result in
            guard let details = result.value else { return completion(nil, result.error) }
            completion(details, nil)
        }
    }
}

// MARK: - TMDb (Movie Poster Image) -

extension TMDb {
    
    func posterImageURL(for movie: Movie, size: String) -> URL? {
        guard let posterPath = movie.poster_path else { return nil }
        let baseURL = URL(string: config.secureBaseImageURLString)!
        return baseURL.appendingPathComponent(size).appendingPathComponent(posterPath)
    }
    
    func posterImageURL(for movie: Movie) -> URL? {
        return posterImageURL(for: movie, size: "w500")
    }
    
}
