//
//  AppDetailsCell.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/21/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class AppDetailsCell: UICollectionViewCell {
  
  var app: Result! {
    didSet{
      nameLabel.text = app?.trackName
      releaseNotesLbl.text = app?.releaseNotes
      appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
      priceBtn.setTitle(app?.formattedPrice, for: .normal)
    }
  }
  
  let appIconImageView = UIImageView(cornerRadius: 16)
  
  let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
  
  let priceBtn = UIButton(title: "$4.99")
  
  let whatsNewLbl = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
  
  let releaseNotesLbl = UILabel(text: "Release Notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    appIconImageView.backgroundColor = .red
    appIconImageView.constrainWidth(constant: 140)
    appIconImageView.constrainHeight(constant: 140)
    
    priceBtn.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.4705882353, blue: 0.9725490196, alpha: 1)
    priceBtn.constrainHeight(constant: 32)
    priceBtn.constrainWidth(constant: 80)
    priceBtn.layer.cornerRadius = 32/2
    priceBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
    priceBtn.setTitleColor(.white, for: .normal)
    
    let stackView = VerticalStackView(arrangedSubviews: [
      UIStackView(arrangedSubviews: [
        appIconImageView,
        VerticalStackView(arrangedSubviews: [
          nameLabel, UIStackView(arrangedSubviews: [priceBtn, UIView()]),
          UIView()
          ], spacing: 12)
        ], customSpacing: 20),
      whatsNewLbl,
      releaseNotesLbl,
      ], spacing: 16)
    
    addSubview(stackView)
    stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}

extension UIStackView {
  convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0){
    self.init(arrangedSubviews: arrangedSubviews)
    self.spacing = customSpacing
  }
}
