//
//  AppRowCell.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/16/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
  
  let imageView = UIImageView(cornerRadius: 8)
  
  let nameLbl = UILabel(text: "App Name ", font: .systemFont(ofSize: 20))
  let compnayLbl = UILabel(text: "Comapny Name", font: .systemFont(ofSize: 13))
  let getBtn = UIButton(title: "GET")
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    imageView.constrainWidth(constant: 64)
    imageView.constrainHeight(constant: 64)
    
    getBtn.backgroundColor = UIColor(white: 0.95, alpha: 1)
    getBtn.constrainWidth(constant: 80)
    getBtn.constrainHeight(constant: 32)
    getBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    getBtn.layer.cornerRadius = 32 / 2
    
    let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [nameLbl, compnayLbl], spacing: 4), getBtn])
    
    stackView.spacing = 16
    stackView.alignment = .center
    
    addSubview(stackView)
    stackView.fillSuperview()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
