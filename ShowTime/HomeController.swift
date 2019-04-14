//
//  HomeController.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 13/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource{
 
    
    let arrayOfCategories = [" Movies", " TV-Shows"]
//    let layout = UICollectionViewFlowLayout()
    

    

    var indexPathRow : Int?
    
    @IBOutlet weak var sortBarItem: UIBarButtonItem! {
        didSet {
            let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
            button.setImage(UIImage(named: "sittings"), for: UIControl.State.normal)
               button.addTarget(self, action: #selector(sortBarItemTapped), for: UIControl.Event.touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 20)
               sortBarItem.customView = button

        }
    }
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        TableView.separatorStyle = .none
        TableView.backgroundColor = .black
        view.backgroundColor = .black
        
      

      

    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCategories.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! MoviesTableViewCell
            cell.moviesCollectionView.dataSource = self
            cell.moviesCollectionView.delegate = self
            cell.moviesCollectionView.tag = indexPath.row
            cell.categoriesLabel.text = " Movies"

            return cell
            
        } else if indexPath.row == 1 {
               let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell2", for: indexPath) as! TVShowsTableViewCell
            cell.TVShowsCollectionView.dataSource = self
            cell.TVShowsCollectionView.delegate = self
            
         
          cell.TVShowsCollectionView.tag = indexPath.row
            
               cell.categoryLabel.text = " TV-Shows"
            
            return cell
        }

    
        return UITableViewCell()
    }
    
    
//
//   func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    {
//
//        if let cell = cell as? MoviesTableViewCell {
//            cell.moviesCollectionView.dataSource = self
//            cell.moviesCollectionView.delegate = self
//                cell.moviesCollectionView.reloadData()
//        }
//
//
//
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt
    indexPath: IndexPath) -> CGFloat
    {
     return tableView.bounds.height / 2
    }
    
    // bar item's functions
    
    @IBAction func searchBarItemTapped(_ sender: Any) {
        print("searchBarItem Tapped")
        
    }
    
    @objc func sortBarItemTapped() {
        print("sortBarItem Tapped")

    }
    
    
    
}

extension HomeController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    override func viewWillAppear(_ animated: Bool) {
      
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let datasourceIndex = collectionView.tag
        if datasourceIndex == 0 {
     
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MoviesCollectionViewCell
            
            item.titleLabel.text = "Venom"
            item.thumbnailImage.image = UIImage(named: "Venom")
            
             return item
            
        } else if datasourceIndex == 1 {
            
            
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell2", for: indexPath) as! TVShowsCollectionViewCell
            
            item.titleLabel.text = "Taylor TV-Show"
            // Taylor TV-Show
            item.thumbnailImage.image = UIImage(named: "Venom")
            // taylor_swift_profile
            
            return item
            
        }
        
  
        
        
        
     return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 3.5
        
        let spacing = (view.frame.width / 10) - 25
        
//        let numberOfItemsPerRow: CGFloat = 2.0
        let itemWidth = (collectionView.bounds.width / 2) - (2 * spacing)
        
        return CGSize(width: itemWidth, height: collectionView.frame.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets.init(top: 0, left: 3.5, bottom: 0, right: 3.5)

    }
    
    
}


