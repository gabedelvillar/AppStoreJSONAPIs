//
//  AppFullScreenController.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/23/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class AppFullScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var dismissHandler: (() -> ())?
  var todayItem: TodayItem?
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < 0 {
      scrollView.isScrollEnabled = false
      scrollView.isScrollEnabled = true
    }
    
      let translationY = -90 - UIApplication.shared.statusBarFrame.height
    
    let transform = scrollView.contentOffset.y > 100 ? CGAffineTransform(scaleX: 0, y: translationY) : .identity
    
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

      self.floatingContainerView.transform = transform
    })
      
    }
  
  let tableView = UITableView(frame: .zero, style: .plain)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.clipsToBounds = true
    
    view.addSubview(tableView)
    tableView.fillSuperview()
    tableView.dataSource = self
    tableView.delegate = self
    
    setupCloseBtn()
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.contentInsetAdjustmentBehavior = .never
    let height = UIApplication.shared.statusBarFrame.height
    tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
    
    
    setupFloatingControls()
  }
     let floatingContainerView = UIView()
  
  @objc fileprivate func handleTap() {
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
      
      self.floatingContainerView.transform = .init(translationX: 0, y: -90)
      
      
    })
  }
  
  fileprivate func setupFloatingControls(){
 
    floatingContainerView.clipsToBounds = true
    floatingContainerView.layer.cornerRadius = 16
    view.addSubview(floatingContainerView)
    //let bottomPadding = UIApplication.shared.statusBarFrame.height
    floatingContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -90, right: 16), size: .init(width: 0, height: 90))
    
    let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    floatingContainerView.addSubview(blurVisualEffectView)
    blurVisualEffectView.fillSuperview()
    
    view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleTap)))
    
    // add our subviews
    let imageView = UIImageView(cornerRadius: 16)
    imageView.image = todayItem?.img
    imageView.constrainWidth(constant: 68)
    imageView.constrainHeight(constant: 68)
    
    let getBtn = UIButton(title: "GET")
    getBtn.setTitleColor(.white, for: .normal)
    getBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    getBtn.backgroundColor = .gray
    getBtn.layer.cornerRadius = 16
    getBtn.constrainWidth(constant: 80)
    getBtn.constrainHeight(constant: 32)
    
    let stackView = UIStackView(arrangedSubviews: [imageView,
                                                   VerticalStackView(arrangedSubviews: [
                                                    UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18)),
                                                    UILabel(text: "Utilizing your Time", font: .systemFont(ofSize: 16))
                                                    ], spacing: 4), getBtn],
                                                    customSpacing: 16)
    
    floatingContainerView.addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    
    stackView.alignment = .center
    
    
    
  }
  
  let closeBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
    return btn
  }()
  
  
  fileprivate func setupCloseBtn(){
    view.addSubview(closeBtn)
    
    closeBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
    closeBtn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
  }
  
//  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let header = TodayCell()
//    return header
//  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.item == 0 {
      
      let headerCell = AppFullScreenHeaderCell()
      
      headerCell.todayCell.todayItem = todayItem
      headerCell.todayCell.layer.cornerRadius = 0
      headerCell.clipsToBounds = true
      headerCell.todayCell.backgroundView = nil
      return headerCell
    }
    
    let cell = AppFullScreenDescriptionCell()
    return cell
    
  }
  
  @objc fileprivate func handleDismiss(button: UIButton){
    button.isHidden = true
    dismissHandler?()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if indexPath.item == 0{
      return TodayController.cellSize
    }
    
    return UITableView.automaticDimension
  }
  
//  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//    return 450
//  }
}
