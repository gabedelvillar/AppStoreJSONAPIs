//
//  MusicLoadingFooter.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 9/8/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let aiv = UIActivityIndicatorView(style: .whiteLarge)
    
    aiv.color = .darkGray
    aiv.startAnimating()
    
    let label = UILabel(text: "Loading More...", font: .systemFont(ofSize: 16))
    label.textAlignment = .center
    let stackView = VerticalStackView(arrangedSubviews: [
      aiv, label
      ], spacing: 8)
    
    addSubview(stackView)
    
    stackView.centerInSuperview(size: .init(width: 200, height: 0))
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
