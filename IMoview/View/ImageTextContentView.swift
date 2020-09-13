//
//  ImageTextContentView.swift
//  IMoview
//
//  Created by User on 9/11/20.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class ImageTextContentView: UIView {
    
    // MARK: - Properties
    
    let bearImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    
    let headerTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.font = UIFont.boldSystemFont(ofSize: 24)
        
        return textView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.font = UIFont.systemFont(ofSize: 18)
        
        return textView
    }()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        
        addSubview(bearImageView)
        bearImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        bearImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        bearImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        addSubview(headerTextView)
        headerTextView.topAnchor.constraint(equalTo: bearImageView.bottomAnchor).isActive = true
        headerTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        headerTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        
        
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: headerTextView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
    }
    
}

