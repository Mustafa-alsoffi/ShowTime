//
//  CategorySelectedVC.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 14/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit

class SelectedCategoryVC: UIViewController{
    
    @IBOutlet weak var tabBar: UITabBar! {
        didSet {
            tabBar.layer.cornerRadius = 30
            tabBar.layer.masksToBounds = true
            tabBar.clipsToBounds = true
            tabBar.itemPositioning = .automatic
            tabBar.tintColor = .white

        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    var navTitle = ""
    var moviesArr : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navTitle
        collectionView.dataSource = self
        collectionView.delegate = self
        tabBar.delegate = self
        setNavigationItems ()
        setupTabBarFrame ()
    }
    
    @objc func sortButtonTapped () {
        print("sortButton Tapped ")
    }
    @objc func searchButtonTapped () {
        print("searchtButton Tapped ")
        
    }
    
    func setNavigationItems () {
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped)) //
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "filter"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(sortButtonTapped), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 31)
        let editBarButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItems  = [search, editBarButton]
        navigationItem.rightBarButtonItem?.tintColor = .white
        
    }
    
}


// MARK:- CollectionViewDate 
extension SelectedCategoryVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArr.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedCateCollectionvCell", for: indexPath) as! SelectedCateCollectionVCell
        item.titleLabel.text = moviesArr[indexPath.row].title
        item.rateLabel.text = String(moviesArr[indexPath.row].voteAverage)
        
        
        item.thumbnailImage.image = UIImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(self.moviesArr[indexPath.row].posterPath)"))
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let spacing = (view.frame.width / 10) - 25
        var width = collectionView.frame.size.width > 500 ? (collectionView.frame.size.width / 3) - (2 * spacing) + 20 : (collectionView.frame.size.width / 2) - (2 * spacing)
        if collectionView.frame.width >= 700 && collectionView.frame.height >= 800 {
            width = (collectionView.frame.size.width / 2) - (2 * spacing)
        }
        
        return CGSize(width: width, height: width * 1.50 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let spacing = (view.frame.width / 10) - 25
        return UIEdgeInsets.init(top: 8, left: spacing, bottom: 0, right: spacing)
        
    }
    
    // this fuction will reload the collectionView to different data when one of the tab bar items is tapped
    func changeCategory() {
        
    }
    
}



// MARK:- TabBarDelegate
extension SelectedCategoryVC : UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.selectedItem?.tag == 0 {

            collectionView.reloadData()
            
        } else if tabBar.selectedItem?.tag == 1 {
            collectionView.reloadData()
        }
        
    }
    
    func setupTabBarFrame () {
        let bottomOfView = view.frame.maxY - 70
        let width = view.frame.width - 10
        let height = view.frame.width / 15
        tabBar.frame = CGRect(x: 5, y: bottomOfView, width: width, height: height)
    }
}
