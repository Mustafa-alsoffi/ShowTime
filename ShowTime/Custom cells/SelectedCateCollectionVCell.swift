//
//  SelectedCateCollectionVCell.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 15/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit

class SelectedCateCollectionVCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView! {
        didSet{
            thumbnailImage.layer.cornerRadius = 30
            
            thumbnailImage.layer.masksToBounds = true
            
            thumbnailImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var starIamge: UIImageView!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var subtitle: UITextView! {
        didSet {
            subtitle.text = "PG-13 | 1hr 52min"
            subtitle.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
            subtitle.textColor = .lightGray
            subtitle.isEditable = false
            subtitle.isUserInteractionEnabled = false
            subtitle.sizeToFit()
            subtitle.backgroundColor = .clear
            
        }
    }
    
}
