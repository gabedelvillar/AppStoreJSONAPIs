//
//  TodayMultipleAppsController.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/25/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class TodayMultipleAppsController: BaseListController, UICollectionViewDelegateFlowLayout {
  
  fileprivate let cellId = "cellId"
  
  var apps = [FeedResult]()
  
  let closeBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
    btn.tintColor = .darkGray
    btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    return btn
  }()
  
  @objc func handleDismiss(){
    dismiss(animated: true, completion: nil)
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let appId = self.apps[indexPath.item].id
    
    let appDetailController = AppDetailController(appId: appId)
    
    navigationController?.pushViewController(appDetailController, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    if mode == .fullscreen{
      setupClosedBtn()
      navigationController?.isNavigationBarHidden = true
    } else {
      collectionView.isScrollEnabled = false
    }
    
    collectionView.backgroundColor = .white
    
    
    collectionView.register(MultipleAppsCll.self, forCellWithReuseIdentifier: cellId)
    
    // never execute fetch code inside of a view
    
    Service.shared.fetchGames { (appGroup, err) in
      
      self.apps = appGroup?.feed.results ?? []
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  override var prefersStatusBarHidden: Bool {return true}
  
  func setupClosedBtn(){
    view.addSubview(closeBtn)
    
    closeBtn.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if mode == .fullscreen {
      return.init(top: 12, left: 24, bottom: 12, right: 24)
    }
    
    return .zero
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if mode == .fullscreen {
      return apps.count
    }
    
    return min(4, apps.count)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppsCll
    cell.app = apps[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let height: CGFloat = 68
    
    if mode == .fullscreen{
      return .init(width: view.frame.width - 48, height: height)
    }
    
    return .init(width: view.frame.width, height: height)
  }
  
  fileprivate let spacing: CGFloat = 16
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return spacing
  }
  
  fileprivate let mode: Mode
  
  enum Mode {
    case small, fullscreen
  }
  
  init(mode: Mode) {
    self.mode = mode
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
