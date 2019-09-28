 //
//  BaseTabBarControlller.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/13/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit
 
 class BaseTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
   
    viewControllers = [
      createNavController(viewController: MusicController(), title: "Music", imageName: "music"),
      createNavController(viewController: TodayController(), title: "Today", imageName: "today_icon"),
       createNavController(viewController: AppsPageController(), title: "Apps", imageName: "apps"),
      createNavController(viewController: AppsSearchController(), title: "Search", imageName: "search"),
      
     
      
      
    ]
    
    
  }
  
  fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController{
    let navController = UINavigationController(rootViewController: viewController)
    navController.navigationBar.prefersLargeTitles = true
    viewController.navigationItem.title = title
    viewController.view.backgroundColor = UIColor.white
    navController.tabBarItem.title = title
    navController.tabBarItem.image = UIImage(named: imageName)
    
    return navController
  }
 }
