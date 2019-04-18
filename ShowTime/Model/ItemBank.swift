//
//  ItemBank.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 16/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit

class ItemBank {
    var dataArray = [Item]()
    
    init() {
        dataArray.append(Item(thumbnail: "Venom", title: "Venom", subtitle: "PG3 | 30 min 1 hr", rating: "(21)"))
        dataArray.append(Item(thumbnail: "taylor_swift_profile", title: "taylor_swift", subtitle: "PG3 | 30 min 1 hr", rating: "(21)"))
    }
    
    
}
