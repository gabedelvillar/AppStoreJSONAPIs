//
//  AppHeaderAppCell.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/17/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
  
  let companyLbl = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
  let titleLbl = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
  
  let imageView = UIImageView(cornerRadius: 8)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    companyLbl.textColor = .blue
    titleLbl.numberOfLines = 2
    let stackView = VerticalStackView(arrangedSubviews: [companyLbl, titleLbl, imageView], spacing: 12)
    
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
