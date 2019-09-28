//
//  AppsGroupCell.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/16/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
  
  let titleLbl = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 30))
  
  let horizontalController = AppsHorizontalController()
  
  override init(frame: CGRect){
    super.init(frame: frame)
    
    addSubview(titleLbl)
    
    titleLbl.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
    
    addSubview(horizontalController.view)
    horizontalController.view.anchor(top: titleLbl.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
