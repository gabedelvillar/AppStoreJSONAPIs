//
//  AppDetailsController.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/20/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
  
  fileprivate let appId: String
  
  //dependency injectino constructor
  
  init(appId: String){
    self.appId = appId
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
 
  
  var app: Result?
  var reviews: Reviews?
  
  let detailCellId = "detailCellId"
  let previewCellId = "previewCellId"
  let reviewCellId = "reviewCellId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
    collectionView.backgroundColor = .white
    collectionView.register(AppDetailsCell.self, forCellWithReuseIdentifier: detailCellId)
    collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: previewCellId)
    collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
    
    fetchData()
  }
  
  fileprivate func fetchData(){
    let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
    Service.shared.fetchGenericJSONData(urlString: urlString) { (result:SearchResult?, err) in
      let app = result?.results.first
      self.app = app
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
      
      
    }
    
    let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?1=en&cc=us"
    
    Service.shared.fetchGenericJSONData(urlString: reviewsUrl) { (reviews: Reviews?, err) in
      if let err = err {
        print("Failed to decode reviews:", err)
        return
      }
      
      self.reviews = reviews
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if indexPath.item == 0{
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailsCell
      cell.app = app
     return cell
    } else if indexPath.item == 1{
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewCellId, for: indexPath) as! PreviewCell
      
      cell.horizontalController.app = self.app
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
      cell.reviewsController.reviews = self.reviews
      return cell
    }
    
 
   
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    var height: CGFloat = 280
    
    if indexPath.item == 0 {
      // Calculate the necessary size for cell
      let dummyCell = AppDetailsCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
      
      dummyCell.app = app
      dummyCell.layoutIfNeeded()
      
      let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
      
      
      height = estimatedSize.height
    } else if indexPath.item == 1 {
      height = 500
    } else{
      height = 280
    }
    
    return .init(width: view.frame.width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 0, left: 0, bottom: 16, right: 0)
  }
}
