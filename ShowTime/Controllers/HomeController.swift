//
//  HomeController.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 13/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let tVShowsBarItem : UITabBarItem = {
        let barItem = UITabBarItem()
        barItem.title = "TV Shows"
        barItem.image = #imageLiteral(resourceName: "Tvshows")
        barItem.tag = 1
        return barItem
    }()
    
    let moviesBarItem : UITabBarItem = {
        let barItem = UITabBarItem()
        barItem.title = "Movies"
        barItem.image = #imageLiteral(resourceName: "Moviesicon")
        barItem.tag = 0
        barItem.badgeTextAttributes(for: .normal)
        return barItem
    }()
    let tabBar: UITabBar = {
        let tabBar = UITabBar()
        
        tabBar.layer.cornerRadius = 30
        tabBar.layer.masksToBounds = true
        tabBar.clipsToBounds = true
        tabBar.itemPositioning = .automatic
        tabBar.tintColor = .white
        tabBar.barTintColor = UIColor(red:0.19, green:0.18, blue:0.18, alpha:1.0)
        return tabBar
    } ()
    let filtersLauncher = FiltersLauncher()
    var movies : [Movie] = []
    
    
    var tVShows : [Tv] = []
    
    var indexPathForSelectedItem = 0
    
    
    // customizing the bar button item here
    @IBOutlet weak var sortBarItem: UIBarButtonItem! {
        didSet {
            let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
            button.setImage(UIImage(named: "filter"), for: UIControl.State.normal)
            button.addTarget(self, action: #selector(sortBarItemTapped), for: UIControl.Event.touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 20)
            sortBarItem.customView = button
            
        }
    }
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load")
        
        
        TableView.delegate = self
        TableView.dataSource = self
        TableView.separatorStyle = .none
        TableView.allowsSelection = false
        tabBar.delegate = self
        
        setupViews()
        
        fetchtVshows()
        fetchMovies()
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    // MARK:- Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let height = view.frame.height / 2.50
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! MoviesTableViewCell
            cell.moviesCollectionView.dataSource = self
            cell.moviesCollectionView.delegate = self
            cell.moviesCollectionView.tag = indexPath.row
            cell.moviesCollectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
            cell.categoriesLabel.text = " Movies"
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell2", for: indexPath) as! TVShowsTableViewCell
            cell.TVShowsCollectionView.dataSource = self
            cell.TVShowsCollectionView.delegate = self
            cell.TVShowsCollectionView.tag = indexPath.row
            cell.TVShowsCollectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
            cell.categoryLabel.text = " TV-Shows"
            
            return cell
        } else if indexPath.row == 2 {
            // This cell is for giving a space to tab bar at the end of the table
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell3")
            cell?.backgroundColor = .black
            let tabBarHeight = self.tabBar.frame.height + 10
            cell?.heightAnchor.constraint(equalToConstant: tabBarHeight).isActive = true
            
            cell?.selectionStyle = .none
            return cell!
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
    // MARK:- Bar items' functions
    
    @IBAction func searchBarItemTapped(_ sender: Any) {
        print("searchBarItem Tapped")
        
    }
    
    @objc func sortBarItemTapped() {
        print("sortBarItem Tapped")
        self.filtersLauncher.showFilters()
    }
    
    // video player configurations
    func setupViews() {
        let bottomOfView = view.frame.maxY - 70
        
        let width = view.frame.width - 10
        let height = view.frame.width / 15
        tabBar.frame = CGRect(x: 5, y: bottomOfView, width: width, height: height)
        
        
        tabBar.setItems([tVShowsBarItem, moviesBarItem], animated: false)
        
        view.addSubview(tabBar)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "TheSelectedCategory" {
            let destinationVC = segue.destination as! SelectedCategoryVC
            
            if tabBar.selectedItem?.tag == 0 {
                destinationVC.navTitle = "Movies"
                for movies in self.movies {
                    destinationVC.moviesArr.append(movies)
                }
                
            } else if tabBar.selectedItem?.tag == 1 {
                destinationVC.navTitle = "TV-Shows"
                
            }
            
        } else if segue.identifier == "Trailer" {
            let destinationVC = segue.destination as! SelectedItemTableVC
            destinationVC.overView = self.movies[indexPathForSelectedItem].overview
            
            
        }
        
    }
    
    // MARK:- Networking
    
    func fetchMovies () {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: {
            MovieAPIService.shared.fetchMovies(from: .topRated) { (result: Result<MoviesResponse, MovieAPIService.APIServiceError>) in
                
                
                
                
                switch result {
                case .success(let movie):
                    
                    //                print(movie)
                    for movies in movie.results {
                        self.movies.append(movies)
                    }
                    DispatchQueue.main.async {
                        self.TableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .left)
                        
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                
            }
            
        })
    }
    
    func fetchtVshows() {
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: {
            MovieAPIService.shared.fetchTvShows(from: .topRated) { (result: Result<TVResponse, MovieAPIService.APIServiceError>) in
                
                
                
                switch result {
                case .success(let tv):
                    
                    for shows in tv.results {
                        
                        self.tVShows.append(shows)
                    }
                    DispatchQueue.main.async {
                        self.TableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .left)
                        
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
        })
        
    }
    
    
}

// MARK:- Extension For UICollectionViewDataSource

extension HomeController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let datasourceIndex = collectionView.tag
        
        if datasourceIndex == 0 {
            
            
            return self.movies.count
            
        } else if datasourceIndex == 1 {
            
            
            return self.tVShows.count
        }
        
        return Int()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let datasourceIndex = collectionView.tag
        if datasourceIndex == 0 {
            
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! MoviesCollectionViewCell
            
            item.thumbnailImage.image = UIImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(self.movies[indexPath.row].posterPath)"))
            item.titleLabel.text = movies[indexPath.row].title
            item.rateLabel.text = String(movies[indexPath.row].voteAverage)
            item.subtitleTextView.text = movies[indexPath.row].releaseDate.asString(style: .medium)

            
            return item
            
        } else if datasourceIndex == 1 {
            
            
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell2", for: indexPath) as! TVShowsCollectionViewCell
            
            item.titleLabel.text = self.tVShows[indexPath.row].name
            item.thumbnailImage.image = UIImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(self.tVShows[indexPath.row].posterPath)"))
            item.rateLabel.text = String(self.tVShows[indexPath.row].voteAverage)
            item.subtitleTextView.text = tVShows[indexPath.row].firstAirDate
            return item
            
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexPathForSelectedItem = indexPath.item
        
        performSegue(withIdentifier: "Trailer", sender: nil)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 3.5
        
        let spacing = (view.frame.width / 10) - 25
        
        let itemWidth = (collectionView.bounds.width / 2) - (2 * spacing)
        
        return CGSize(width: itemWidth, height: collectionView.frame.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        return UIEdgeInsets.init(top: 0, left: 3.5, bottom: 0, right: 3.5)
        
    }
    
    
}

// MARK:- Extension For UITabBarDelegate
extension HomeController : UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        performSegue(withIdentifier: "TheSelectedCategory", sender: nil)
        
    }
    
}



