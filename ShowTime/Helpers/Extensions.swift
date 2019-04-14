//
//  Extensions.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 14/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func setNavigationItems (sortButtonTarget : Selector, searchButtonTarget : Selector) {
    let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: searchButtonTarget) //
    let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
    button.setImage(UIImage(named: "sittings"), for: UIControl.State.normal)
        button.addTarget(self, action: sortButtonTarget, for: UIControl.Event.touchUpInside)
    button.frame = CGRect(x: 0, y: 0, width: 44, height: 31)
    let editBarButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItems  = [search, editBarButton]
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
}
