//
//  MovieCell.swift
//  IMoview
//
//  Created by User on 9/10/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    let bgImageView: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        
        return iv
    }()
    
    var title: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        
        return title
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bgImageView)
        bgImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bgImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bgImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
//        bgImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(title)
        title.topAnchor.constraint(equalTo: bgImageView.bottomAnchor, constant: 8.0).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        contentView.addSubview(subtitle)
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 1.0).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        
        contentView.addSubview(rate)
        rate.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 1.0).isActive = true
        rate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        rate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        rate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
