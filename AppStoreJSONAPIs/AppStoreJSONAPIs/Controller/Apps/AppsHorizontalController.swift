//
//  AppsHorizontalController.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/16/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
  
  fileprivate let cellID = "CellID"
  
  var appGroup: AppGroup?
  
  var didSelectHandler: ((FeedResult) -> ())?
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let app = appGroup?.feed.results[indexPath.item] {
      didSelectHandler?(app)
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.backgroundColor = .white
    
    collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellID)
    
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return appGroup?.feed.results.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppRowCell
    let app = appGroup?.feed.results[indexPath.item]
    cell.nameLbl.text = app?.name
    cell.compnayLbl.text = app?.artistName
    cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? "")) 
    return cell
  }
  
  let topBottomPadding: CGFloat = 12
  let lineSpacing: CGFloat = 10
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
    
    return .init(width: view.frame.width - 48, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return lineSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
  }
  
}
