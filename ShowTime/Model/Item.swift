//
//  Video.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 15/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import Foundation
import UIKit
class Item {
    var thumbnailImage : String?
    var titleText : String?
    var subtitleText : String?
    var ratingLabel : String?
    init(thumbnail: String, title : String, subtitle : String, rating : String) {
        thumbnailImage = thumbnail
        titleText = title
        subtitleText = subtitle
        ratingLabel = rating
    }
}
