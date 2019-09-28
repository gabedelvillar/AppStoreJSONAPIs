//
//  BetterSnappingLayout.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/20/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class BetterSnappingLayout: UICollectionViewFlowLayout {
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else {return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)}
    
    let nextX: CGFloat
    
    if proposedContentOffset.x <= 0 || collectionView.contentOffset == proposedContentOffset {
      nextX = proposedContentOffset.x
    } else {
      nextX = collectionView.contentOffset.x + (velocity.x > 0 ? collectionView.bounds.size.width : -collectionView.bounds.size.width)
    }
    
    let targetRect = CGRect(x: nextX, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.height)
    
    var offsetAdjustment = CGFloat.greatestFiniteMagnitude
    let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
    
    let layoutAtrributesArray = super.layoutAttributesForElements(in: targetRect)
    
    layoutAtrributesArray?.forEach({(layoutAttributes) in
      let itemOffset = layoutAttributes.frame.origin.x
      if fabsf(Float(itemOffset - horizontalOffset)) <
        fabsf(Float(offsetAdjustment)) {
        offsetAdjustment = itemOffset - horizontalOffset
      }
    })
    
    return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
  }
}
