//
//  AppGroup.swift
//  AppStoreJSONAPIs
//
//  Created by Gabriel Del VIllar on 8/18/19.
//  Copyright © 2019 gdelvillar. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
  let feed: Feed
}

struct Feed: Decodable {
  let title: String
  let results: [FeedResult]
}

struct FeedResult: Decodable {
  let id, name, artistName, artworkUrl100: String
}
