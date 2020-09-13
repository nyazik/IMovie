//
//  SearchMovieVC.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class SearchMovieVC: UIViewController {
    
    // MARK: - Internal Views
    var tableView: UITableView = {
        var tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionIndexBackgroundColor = .white
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInset.bottom = 100.0
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseIdentifier)
        
        return tableView
    }()
    
    var emptyView: ImageTextContentView = {
        let view = ImageTextContentView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bearImageView.image = #imageLiteral(resourceName: "emptySearch")
        view.headerTextView.text = "Search..."
        view.descriptionTextView.text = "no reslut found"
        return view
    }()
    
    var containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.clipsToBounds = true
        
        return container
    }()
    
    var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = .gray
            searchController.searchBar.searchTextField.textColor = .black
        }
        
        return searchController
    }()
    
    fileprivate let activityView: UIActivityIndicatorView = {
        let activity =  UIActivityIndicatorView(style: .whiteLarge)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        
        return activity
    }()
    
    let loadingView: UIView = UIView()
    
    var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    
    var tmdb: TMDb!
    var viewModel: SearchViewModel!
    var movies: [Movie] = []
    var bag: DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bag = DisposeBag()
        setupTableView()
        showEmptyView()
        setupSearchController()
        setupActivityIndicatory()
        
        viewModel = SearchViewModel(tmdb: tmdb)
        viewModel.movies
            .subscribe(onNext: { movies in
                self.movies = movies
                let offset = self.tableView.contentOffset
                self.tableView.reloadData()
                self.tableView.setContentOffset(offset, animated: false)
                movies.isEmpty ? self.showEmptyView() : self.removeEmptyView()
            }, onError: { (error) in
                self.showErrorMessage(of: error.localizedDescription)
            }).disposed(by: bag)
        
        viewModel.isLoading
            .subscribe(onNext:{value in
                self.loadingView.isHidden = !value
            })
            .disposed(by: bag)
        
        searchController.searchBar
        .rx.text // Observable property thanks to RxCocoa
        .orEmpty // Make it non-optional
        .debounce(.milliseconds(500), scheduler: MainScheduler.instance) // Wait 0.5 for changes.
        .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
        .filter { !$0.isEmpty }
        .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value
            self.viewModel.search(query: query)
        })
        .disposed(by: bag)
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


// MARK: - Fileprivate Methods
extension SearchMovieVC {
    
    // MARK: - Setup Methods
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupSearchController() {
        navigationItem.searchController = searchController
    }
    
    public func removeEmptyView() {
        emptyView.removeFromSuperview()
    }
    
    public func showEmptyView() {
        emptyView.removeFromSuperview()
        view.addSubview(emptyView)
        emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
    }
}

extension SearchMovieVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseIdentifier, for: indexPath) as! SearchCell
        cell.avaterImage.kf.setImage(with: tmdb.posterImageURL(for: movie))
        cell.title.text = movie.title
        cell.descriptionLbl.text = movie.overview
        cell.subtitle.text = "📅 \(movie.release_date ?? "N/A")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        viewModel.scrollViewDidEndDragging(tableView: tableView, scrollView, willDecelerate: decelerate)
    }
}
