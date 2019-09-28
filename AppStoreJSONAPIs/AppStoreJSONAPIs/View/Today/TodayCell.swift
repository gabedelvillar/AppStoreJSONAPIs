//
//  TodayCell.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/23/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {
  
 override var todayItem: TodayItem! {
    didSet{
      categoryLbl.text = todayItem.category
      titleLbl.text = todayItem.title
      imgView.image = todayItem.img
      descriptionLbl.text = todayItem.description
      backgroundColor = todayItem.backgroundColor
      backgroundView?.backgroundColor = todayItem.backgroundColor
    }
  }
  
  let categoryLbl = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
  
  let titleLbl = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32))
  
  let imgView = UIImageView(image: #imageLiteral(resourceName: "garden"))
  
  let descriptionLbl = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way", font: .systemFont(ofSize: 16), numberOfLines: 3)
  
  var topConstraint: NSLayoutConstraint?
  
 override init(frame: CGRect) {
    super.init(frame: frame)
  
  backgroundColor = .white
  //clipsToBounds = true
  layer.cornerRadius = 16
  
  imgView.contentMode = .scaleAspectFill
  imgView.clipsToBounds = true
  
  let imageContainerView = UIView()
  imageContainerView.addSubview(imgView)
  imgView.centerInSuperview(size: .init(width: 240, height: 240))
  
  let stackView = VerticalStackView(arrangedSubviews: [
    categoryLbl, titleLbl, imageContainerView, descriptionLbl
    ], spacing: 8)
  
  addSubview(stackView)
  
  stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
  
  self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
  self.topConstraint?.isActive = true
  
  //stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
 
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
