//
//  SearchViewModel.swift
//  IMoview
//
//  Created by User on 9/11/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class SearchViewModel {
    
    var tmdb: TMDb!
    var pageNo:Int=1
    
    private var _movies = BehaviorSubject<[Movie]>(value: [])
    private var _isDataLoading = BehaviorRelay<Bool>(value: false)
    
    var movies: Observable<[Movie]> {
        return _movies.asObservable()
    }
    
    var isLoading: Observable<Bool> {
        return _isDataLoading.asObservable()
    }
    
    init(tmdb: TMDb) {
        self.tmdb = tmdb
    }
    
    func search(query: String) {
        _isDataLoading.accept(true)
        self.tmdb.searchMovie(query: query, page: self.pageNo){ (movies, error) in
            guard error == nil else { self._movies.onError(error!); return }
            self._movies.onNext(movies ?? [])
            print(movies)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self._isDataLoading.accept(false)
            }
        }
    }
    
    func scrollViewDidEndDragging(tableView: UITableView, _ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height - 500)
        {
            if !_isDataLoading.value{
//                self.pageNo += 1
//                self.load(query: "me")
            }
        }
    }
}
