//
//  DetailsTableVCell.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 24/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit

class DetailsTableVCell: UITableViewCell {
    
    @IBOutlet weak var DiscriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var detailsStackView: UIStackView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
