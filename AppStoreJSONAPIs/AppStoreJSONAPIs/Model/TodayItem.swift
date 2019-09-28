//
//  TodayItem.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/24/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

struct TodayItem {
  let category: String
  let title: String
  let img: UIImage
  let description: String
  let backgroundColor: UIColor
  
  //enum
  
  let cellType: CellType
  
  let apps: [FeedResult]
  
  enum CellType: String {
    case single, multiple
  }
  
}
