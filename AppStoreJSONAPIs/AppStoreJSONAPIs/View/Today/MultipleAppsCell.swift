//
//  MultipleAppsCell.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/25/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class MultipleAppsCll: UICollectionViewCell {
  
  var app: FeedResult! {
    didSet {
      nameLbl.text = app.name
      compnayLbl.text = app.artistName
      imageView.sd_setImage(with: URL(string: app.artworkUrl100))    }
  }
  
  let imageView = UIImageView(cornerRadius: 8)
  
  let nameLbl = UILabel(text: "App Name ", font: .systemFont(ofSize: 20))
  let compnayLbl = UILabel(text: "Comapny Name", font: .systemFont(ofSize: 13))
  let getBtn = UIButton(title: "GET")

  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
    return view
  }()
  
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
    
    addSubview(separatorView)
    
    separatorView.anchor(top: nil, leading: nameLbl.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0), size: .init(width: 0, height: 0.5))
  }
  
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
