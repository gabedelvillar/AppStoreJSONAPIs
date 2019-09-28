//
//  TodayMultipleAppCell.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/24/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
  
  override var todayItem: TodayItem! {
    didSet{
      categoryLbl.text = todayItem.category
      titleLbl.text = todayItem.title
    
      multipleAppsController.apps = todayItem.apps
      multipleAppsController.collectionView.reloadData()
      
      
    }
  }
  
  let categoryLbl = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
  
  let titleLbl = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
  
  let multipleAppsController = TodayMultipleAppsController(mode: .small)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    layer.cornerRadius = 16
    
    
    
    let stackView = VerticalStackView(arrangedSubviews: [
      categoryLbl,
      titleLbl,
      multipleAppsController.view
      ], spacing: 12)
    
    addSubview(stackView)
    
    stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
