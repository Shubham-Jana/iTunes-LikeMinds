//
//  APIModel.swift
//  NewProjectTest
//
//  Created by iOS Wizard on 13/03/23.
//

import Foundation

struct APIData: Codable {
  let results: [Results]
}

struct Results: Codable {
  let description: String?
  let collectionPrice: Double?
  let artistName: String
  let artworkUrl60: URL?
}
