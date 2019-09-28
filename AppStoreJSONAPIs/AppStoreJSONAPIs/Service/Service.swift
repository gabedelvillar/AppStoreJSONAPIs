//
//  Service.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/15/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import Foundation

class Service {
  static let shared = Service() //singleton
  
  func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
    let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
    
    fetchGenericJSONData(urlString: urlString, completion: completion)
    
//    guard let url = URL(string: urlString) else {return}
//
//    //fetch data from internet
//    URLSession.shared.dataTask(with: url) { (data, resp, err) in
//
//      if let err = err {
//        print("Failed to fetch apps: ", err)
//        completion([], nil)
//        return
//
//        //success
//        guard let data = data else {return}
//
//        do {
//          let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
//
//
//          completion(searchResult.results, nil)
//
//        } catch let jsonErr {
//          print("Failed to decode json: ", jsonErr)
//          completion([], jsonErr)
//        }
//
//
//
//
//      }
//
//      }.resume()  // fires off the request

  }
  
  func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
    
    let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
   
    
    fetchAppGroup(urlString: urlString, completion: completion)
    
  }
  
   func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
    
     fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json", completion: completion)
  }
  
  //helper
  func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void){
   
   
    
   fetchGenericJSONData(urlString: urlString, completion: completion)
    
  }
  
  func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
    let urlString = "https://api.letsbuildthatapp.com/appstore/social"
    
   fetchGenericJSONData(urlString: urlString, completion: completion)
  }
  
  
  // generic json function
  func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?)->()) {
    guard let url = URL(string: urlString ) else {return}
    
    
    URLSession.shared.dataTask(with: url) { (data, resp, err) in
      
      if let err = err {
        completion(nil, err)
        return
      }
      
      do{
        let objects = try JSONDecoder().decode(T.self, from: data!)
        // success
        completion(objects, nil)
      } catch {
        completion(nil, error)
      }
      
      
      }.resume() // this will fire request
  }
  
}
