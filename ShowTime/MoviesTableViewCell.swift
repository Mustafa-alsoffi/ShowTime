//
//  TableViewCell.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 13/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell{

    

    @IBOutlet weak var moviesCollectionView: UICollectionView! {
        didSet {
            moviesCollectionView.backgroundColor = .black
        }
    }
    
 
    
    @IBOutlet weak var categoriesLabel: UILabel!
    
 
    
}
