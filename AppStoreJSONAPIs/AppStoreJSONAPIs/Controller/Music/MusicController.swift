//
//  MusicController.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 9/8/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import UIKit

class MusicController: BaseListController, UICollectionViewDelegateFlowLayout {
  
  fileprivate let cellId = "cellId"
  fileprivate let footerId = "footerId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.backgroundColor = .white
    
    collectionView.register(TrackCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
    
    
    fetchData()
  }
  
  var results = [Result]() // blank empty array
  
  fileprivate let searchTerm = "taylor"
  
  fileprivate func fetchData() {
    let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
    
    Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in
      
      if let err = err {
        print("failed to paginate data")
        return
      }
      
     
     
      
      self.results = searchResult?.results ?? []
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
      
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
    
    return footer
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 100)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return results.count
  }
  
  var isPaginating = false
  var isDonePaginating = false
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TrackCell
    
    let track = results[indexPath.item]
    
    cell.nameLbl.text = track.trackName
    cell.imageView.sd_setImage(with: URL(string: track.artworkUrl100))
    cell.subTitleLbl.text = "\(track.artistName ?? "") • \(track.collectionName ?? "")"
    
    
    // initiate pagination
    if indexPath.item == results.count - 1 && !isPaginating{
      
      isPaginating = true
      
      let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
      
      Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in
        
        if let err = err {
          print("failed to paginate data")
          return
        }
        
        if searchResult?.results.count == 0 {
          self.isDonePaginating = true
        }
        
        sleep(2)
        
        self.results += searchResult?.results ?? []
        
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
        
        self.isPaginating = false
        
      }
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let height: CGFloat = isDonePaginating ? 0 : 100
    
    return .init(width: view.frame.width, height: height)
  }
}
