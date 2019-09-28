//
//  AppsController.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/16/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
  
  let cellID = "id"
  let headerID = "headerID"
  
  let activityIndicatorView: UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView(style: .whiteLarge)
    aiv.color = .black
    aiv.startAnimating()
    aiv.hidesWhenStopped = true
    return aiv
  }()
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = UIColor.white
    
    collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellID)
    
    
    // 1
    collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
    
    view.addSubview(activityIndicatorView)
    activityIndicatorView.fillSuperview()
    
    fetchData()
    
  }
  
  var socialApps = [SocialApp]()
  var groups = [AppGroup]()
  
  fileprivate func fetchData(){
    
    var group1: AppGroup?
    var group2: AppGroup?
    var group3: AppGroup?
    
    // help you sync your data fetches together
    let dispatchGroup = DispatchGroup()
    
    dispatchGroup.enter()
    
    Service.shared.fetchGames { (appGroup, err) in
       dispatchGroup.leave()
        group1 = appGroup
    }
    
    dispatchGroup.enter()
    Service.shared.fetchTopGrossing { (appGroup, err) in
      dispatchGroup.leave()
      group2 = appGroup
    }
    
    dispatchGroup.enter()
    Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json") {
      (appGroup, err) in
       dispatchGroup.leave()
      group3 = appGroup
    }
    
    dispatchGroup.enter()
    Service.shared.fetchSocialApps { (apps, err) in
      dispatchGroup.leave()
      self.socialApps = apps ?? []
    }
    
    // completion
    dispatchGroup.notify(queue: .main) {
      
      self.activityIndicatorView.stopAnimating()
      
      if let group = group1 {
        self.groups.append(group)
      }
      if let group = group2 {
        self.groups.append(group)
      }
      if let group = group3 {
        self.groups.append(group)
      }
      
      self.collectionView.reloadData()
    }
    
    }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return groups.count
  }
  
  // 2
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! AppsPageHeader
    
    header.appHeaderHorizontalController.socialApps = self.socialApps
    header.appHeaderHorizontalController.collectionView.reloadData()
    return header
  }
  
  // 3
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.height, height: 300)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsGroupCell
    
    let appGroup = groups[indexPath.item]
    
    cell.titleLbl.text = appGroup.feed.title
    cell.horizontalController.appGroup = appGroup
    cell.horizontalController.collectionView.reloadData()
    cell.horizontalController.didSelectHandler = {[weak self] feedResult in
      
       let detailsController = AppDetailController(appId: feedResult.id)
      detailsController.navigationItem.title = feedResult.name
      
      self?.navigationController?.pushViewController(detailsController, animated: true)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 0, right: 0)
  }
  
 
}

