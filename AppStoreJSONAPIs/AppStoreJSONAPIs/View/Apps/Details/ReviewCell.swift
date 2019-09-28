//
//  ReviewCell.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/21/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell{
  
  let titleLbl = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
  
  let authorLbl = UILabel(text: "Author", font: .systemFont(ofSize: 16))
  
  let startLbl = UILabel(text: "Stars", font: .systemFont(ofSize: 14))
  
  let startsStackView: UIStackView = {
    var arrangedSubviews = [UIView]()
    (0..<5).forEach({(_) in
      let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
      imageView.constrainWidth(constant: 24)
      imageView.constrainHeight(constant: 24)
      arrangedSubviews.append(imageView)
    })
    
    arrangedSubviews.append(UIView())
    
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    
    return stackView
  }()
  
  let bodyLbl = UILabel(text: "Reivew body\nReview body\nReview body", font: .systemFont(ofSize: 18), numberOfLines: 5)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9450980392, blue: 0.9803921569, alpha: 1)
    
    layer.cornerRadius = 16
    clipsToBounds = true
    
    let stackView = VerticalStackView(arrangedSubviews: [
      UIStackView(arrangedSubviews: [
        titleLbl, authorLbl
        ], customSpacing: 8),
      startsStackView,
      bodyLbl
      ], spacing: 12)
    
    titleLbl.setContentCompressionResistancePriority(.init(0), for: .horizontal)
    authorLbl.textAlignment = .right
    
    addSubview(stackView)
//    stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
