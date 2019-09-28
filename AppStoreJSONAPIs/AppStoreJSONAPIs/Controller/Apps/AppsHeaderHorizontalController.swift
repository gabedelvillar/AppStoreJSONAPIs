//
//  AppsHeaderHorizontalController.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/17/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
  
  let cellID = "CellID"
  var socialApps = [SocialApp]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    
    collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellID)
    
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 48, height: view.frame.height)
  }
  
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//    return .init(top: 0, left: 16, bottom: 0, right: 16)
//  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return socialApps.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsHeaderCell
    
    let app = self.socialApps[indexPath.item]
    
    cell.companyLbl.text = app.name
    cell.titleLbl.text = app.tagline
    cell.imageView.sd_setImage(with: URL(string: app.iamgeUrl))
    
    return cell
  }
}
