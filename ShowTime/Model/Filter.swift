//
//  Filter.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 01/06/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import Foundation


class Filter: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
