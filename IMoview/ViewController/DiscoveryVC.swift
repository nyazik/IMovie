//
//  DiscoveryVC.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class DiscoveryVC: UIViewController {
    
    // MARK: - View
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MovieCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    fileprivate let activityView: UIActivityIndicatorView = {
        let activity =  UIActivityIndicatorView(style: .whiteLarge)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        
        return activity
    }()
    
    let loadingView: UIView = UIView()
    
    // MARK: - Properties
    var tmdb: TMDb!
    var viewModel: DiscoveryViewModel!
    var movies: [Movie] = []
    var bag: DisposeBag!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bag = DisposeBag()
        viewModel = DiscoveryViewModel(tmdb: tmdb)
        viewModel.movies
            .subscribe(onNext: { movies in
                self.movies += movies
                let offset = self.collectionView.contentOffset
                self.collectionView.reloadData()
                self.collectionView.setContentOffset(offset, animated: false)
            }, onError: { (error) in
                self.showErrorMessage(of: error.localizedDescription)
            }).disposed(by: bag)
        
        viewModel.isLoading
            .subscribe(onNext:{value in
                self.loadingView.isHidden = !value
            })
            .disposed(by: bag)
        
        setupCollectionView()
        setupActivityIndicatory()
    }
    
    private func setupCollectionView(){
        view.addSubview(collectionView)
        view.backgroundColor = .white
        collectionView.contentInset.top = 16
        collectionView.contentInset.bottom = 16
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupActivityIndicatory() {
        loadingView.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 0.7028306935)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        loadingView.addSubview(activityView)
        activityView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        view.addSubview(loadingView)
        
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
}


// MARK: UICollectionViewDelegateFlowLayout & UICollectionViewDataSource-
extension DiscoveryVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.1, height: collectionView.frame.width/1)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCell
        let movie = self.movies[indexPath.item]
        cell.bgImageView.kf.setImage(with: tmdb.posterImageURL(for: movie))
        cell.title.text = movie.title
        cell.subtitle.text = "📅 \(movie.release_date ?? "N/A")"
        cell.rate.text = "⭐️ \(movie.vote_average)/10 (\(movie.vote_count))"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = movies[indexPath.item]
        let controller = MovieDetailsVC(nibName: nil, bundle: nil)
        controller.movie = movie
        controller.tmdb = tmdb
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        viewModel.scrollViewDidEndDragging(collectionView: collectionView, scrollView, willDecelerate: decelerate)
    }
}
