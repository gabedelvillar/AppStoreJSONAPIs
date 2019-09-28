//
//  ReviewsController.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/21/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class ReviewsController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
  
  let cellID = "cellID"
  
  var reviews: Reviews? {
    didSet{
      self.collectionView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cellID)
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16) 
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return reviews?.feed.entry.count ?? 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ReviewCell
    
    let entry = self.reviews?.feed.entry[indexPath.item]
    
    cell.titleLbl.text = entry?.title.label
    cell.authorLbl.text = entry?.author.name.label
    cell.bodyLbl.text = entry?.content.label
    
    for (index, view) in
      cell.startsStackView.arrangedSubviews.enumerated() {
        if let ratingInt = Int(entry!.rating.label) {
          view.alpha = index >= ratingInt ? 0:1
        }
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width - 48, height: view.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 16
  }
}
