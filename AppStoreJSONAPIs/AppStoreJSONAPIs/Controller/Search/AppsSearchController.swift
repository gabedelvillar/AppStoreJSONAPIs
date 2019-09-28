//
//  AppsSearchController.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/14/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
 
  fileprivate let cellID = "CellID"
  
  fileprivate let searchController = UISearchController(searchResultsController: nil)
  
  fileprivate let enterSearchTermLbl: UILabel = {
    let lbl = UILabel()
    lbl.text = "Please Enter search term above..."
    lbl.textAlignment = .center
    lbl.font = UIFont.boldSystemFont(ofSize: 20)
    return lbl
  }()
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let appId = String(appResults[indexPath.item].trackId)
    let appDetailController = AppDetailController(appId: appId)
    
    navigationController?.pushViewController(appDetailController, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = UIColor.white
    
    collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: cellID)
    
    collectionView.addSubview(enterSearchTermLbl)
    enterSearchTermLbl.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
    
    setupSearchBar()
    
//    fetchITunesApps()
  }
  
  fileprivate func setupSearchBar() {
    definesPresentationContext = true
    navigationItem.searchController = self.searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
  }
  
  var timer: Timer?
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    //inroduce some delay before perfomring the search
    // throttling the search
    
    timer?.invalidate()
    
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
      
      // this will actually fire my search
      Service.shared.fetchApps(searchTerm: searchText) { (res, err) in
        
        if let err = err {
          print("Failed to fetch apps: ", err)
        }
        
        self.appResults = res?.results ?? []
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      }
    })
    
  }
  
  fileprivate var appResults = [Result]()
  
  fileprivate func fetchITunesApps() {
    
    Service.shared.fetchApps(searchTerm: "Twitter") { (res, err) in
      if let err = err {
        print("Failed to fetch apps: ", err)
        return
      }
      
      self.appResults = res?.results ?? []
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
    
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 350)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    enterSearchTermLbl.isHidden = appResults.count != 0
    return appResults.count
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultsCell
    cell.appResult = appResults[indexPath.item]
    return cell
  }
  
  

}
