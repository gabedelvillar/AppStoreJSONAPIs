//
//  BaseListController.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/16/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController {
  init(){
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
