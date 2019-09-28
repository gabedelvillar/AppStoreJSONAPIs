//
//  BackEnabledNavigationController.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/28/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class BackEnableNavigationController: UINavigationController, UIGestureRecognizerDelegate {
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.interactivePopGestureRecognizer?.delegate = self
  }
  
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return self.viewControllers.count > 1
  }
}
