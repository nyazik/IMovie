//
//  SearchCell.swift
//  IMoview
//
//  Created by User on 9/11/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    static let reuseIdentifier: String = "SearchCell"
    
    var avaterImage: UIImageView = {
        var icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 12
        icon.layer.masksToBounds = true
        icon.image = nil
        
        return icon
    }()
    
    var title: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
        title.numberOfLines = 0
        
        return title
    }()
    
    var descriptionLbl: UILabel = {
        var subtitle = UILabel()
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.font = UIFont.systemFont(ofSize: 14)
        subtitle.numberOfLines = 0
        
        return subtitle
    }()
    
    var subtitle: UILabel = {
        var subtitle = UILabel()
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        subtitle.font = UIFont.systemFont(ofSize: 14)
        subtitle.numberOfLines = 0
        
        return subtitle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupListModeViewConstraint()
        backgroundColor = .white
        let customSelectedBackgroundView = UIView()
        customSelectedBackgroundView.backgroundColor = .lightGray
        selectedBackgroundView = customSelectedBackgroundView
        separatorInset.left = 30
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupListModeViewConstraint() {
        
        contentView.addSubview(avaterImage)
        avaterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        avaterImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        avaterImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        avaterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        avaterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [title, descriptionLbl, subtitle])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
    
        contentView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: avaterImage.topAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: avaterImage.trailingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: avaterImage.bottomAnchor).isActive = true
        
//        contentView.addSubview(title)
//        title.topAnchor.constraint(equalTo: avaterImage.topAnchor, constant: 0).isActive = true
//        title.leadingAnchor.constraint(equalTo: avaterImage.trailingAnchor, constant: 16).isActive = true
//        title.heightAnchor.constraint(equalToConstant: 23).isActive = true
//        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//
//        contentView.addSubview(subtitle)
//        subtitle.bottomAnchor.constraint(equalTo: avaterImage.bottomAnchor, constant: 0).isActive = true
//        subtitle.leadingAnchor.constraint(equalTo: avaterImage.trailingAnchor, constant: 16).isActive = true
//        subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
//        subtitle.heightAnchor.constraint(equalToConstant: 23).isActive = true
    }
}
