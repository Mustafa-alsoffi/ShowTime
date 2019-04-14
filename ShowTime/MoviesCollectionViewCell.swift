//
//  CollectionViewCell.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 13/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView! {
        didSet{
            thumbnailImage.layer.cornerRadius = 30

            thumbnailImage.layer.masksToBounds = true
            
            thumbnailImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    @IBOutlet weak var subtitleTextView: UITextView! {
        didSet {
            subtitleTextView.text = "PG-13 | 1hr 52min"
            subtitleTextView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
            subtitleTextView.textColor = .lightGray
            subtitleTextView.isEditable = false
            subtitleTextView.isUserInteractionEnabled = false
            subtitleTextView.sizeToFit()
            subtitleTextView.backgroundColor = .clear

        }
    }
    
    
    
    
}
