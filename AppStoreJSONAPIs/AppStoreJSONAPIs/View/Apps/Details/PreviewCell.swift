//
//  PreviewCell.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/21/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class PreviewCell: UICollectionViewCell {
  
  let previewLbl = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
  let horizontalController = PreviewScreenshotsController()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    addSubview(previewLbl)
    addSubview(horizontalController.view)
    
    previewLbl.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    
    horizontalController.view.anchor(top: previewLbl.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
