//
//  SearchResult.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/15/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import Foundation


struct SearchResult: Decodable {
  let resultCount: Int
  let results: [Result]
}

struct Result: Decodable {
  let trackId: Int
  let trackName: String
  let primaryGenreName: String
  var averageUserRating: Float?
  var screenshotUrls: [String]?
  let artworkUrl100: String // app icon
  var formattedPrice: String?
  var description: String?
  var releaseNotes: String?
  var artistName: String?
  var collectionName: String?
}
