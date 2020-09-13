//
//  TopRatedMoviesViewModel.swift
//  IMoview
//
//  Created by User on 9/10/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class TopRatedMoviesViewModel {
    
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
        load()
    }
    
    private func load() {
        _isDataLoading.accept(true)
        self.tmdb.topRatedMovies(page: self.pageNo) { (movies, error) in
            guard error == nil else { self._movies.onError(error!); return }
            self._movies.onNext(movies ?? [])
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Change `2.0` to the desired number of seconds.
                self._isDataLoading.accept(false)
            }
        }
    }
    
    func scrollViewDidEndDragging(collectionView: UICollectionView, _ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((collectionView.contentOffset.y + collectionView.frame.size.height) >= collectionView.contentSize.height - 500)
        {
            if !_isDataLoading.value{
                self.pageNo += 1
                self.load()
            }
        }
    }
}
