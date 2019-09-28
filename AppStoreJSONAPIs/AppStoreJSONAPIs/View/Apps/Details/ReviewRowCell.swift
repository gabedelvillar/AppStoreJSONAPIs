//
//  ReviewRowCell.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/21/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit


class ReviewRowCell: UICollectionViewCell {
  
  let reviewsController = ReviewsController()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(reviewsController.view)
    reviewsController.view.fillSuperview()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
