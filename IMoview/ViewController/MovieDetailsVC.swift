//
//  MovieDetailsVC.swift
//  IMoview
//
//  Created by User on 9/9/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit
import Kingfisher
class MovieDetailsVC: UIViewController {
var tmdb: TMDb!
    //TODO:: create these components
//    @IBOutlet weak var name: UILabel!
//    @IBOutlet weak var overview: UILabel!
//    @IBOutlet weak var rating: UILabel!
//    @IBOutlet weak var releaseDate: UILabel!
//    @IBOutlet weak var genresLabel: UILabel!
//    @IBOutlet weak var imageView: UIImageView!
    
    var movie: Movie!
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()


    var subtitle: UILabel = {
        var subtitle = UILabel()
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.font = UIFont.systemFont(ofSize: 14)
        
        return subtitle
    }()
    
    var rate: UILabel = {
        var subtitle = UILabel()
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.font = UIFont.systemFont(ofSize: 14)
        subtitle.textColor = .brown
        
        return subtitle
    }()
    
    var overview: UILabel = {
        var subtitle = UILabel()
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.font = UIFont.systemFont(ofSize: 14)
        subtitle.textColor = .black
        subtitle.lineBreakMode = .byWordWrapping
        subtitle.numberOfLines = 10
        return subtitle
    }()
    
    
    
    lazy var img = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

      
        
        view.addSubview(img)
        view.addSubview(movieTitle)
        view.addSubview(subtitle)
        view.addSubview(rate)
        view.addSubview(overview)

        
        img.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        img.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        img.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        img.widthAnchor.constraint(equalToConstant: 200).isActive = true
        img.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        
        movieTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 410).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        
        subtitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 450).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        rate.topAnchor.constraint(equalTo: view.topAnchor, constant: 450).isActive = true
        rate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150).isActive = true
        
        overview.topAnchor.constraint(equalTo: view.topAnchor, constant: 490).isActive = true
        overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        overview.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true

        
        img.kf.setImage(with: tmdb.posterImageURL(for: movie))
        movieTitle.text = movie.title
        subtitle.text = "📅 \(movie.release_date ?? "N/A")"
        rate.text = "⭐️ \(movie.vote_average)/10 (\(movie.vote_count))"
        overview.text = movie.overview
    }
 
    
    
        
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
}
        
        //        view.addSubview(img)
        //        img.widthAnchor.constraint(equalToConstant: 500).isActive = true
        //        img.heightAnchor.constraint(equalToConstant: 500).isActive = true
        //        img.center = view.center
        //        img.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //        img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                
                //view.addSubview(movieTitle)
                
//        img.widthAnchor.constraint(equalToConstant: 500).isActive = true
//        img.heightAnchor.constraint(equalToConstant: 500).isActive = true
//        img.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//
//        view.addSubview(movieOverview)
//        img.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
