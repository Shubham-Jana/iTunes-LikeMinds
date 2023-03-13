//
//  APICaller.swift
//  NewProjectTest
//
//  Created by iOS Wizard on 13/03/23.
//

import Foundation

enum APIError: Error {
  case failedURL
}

final class APICaller {
  
  static let shared = APICaller()
  
  private init() { }
  
  public func downloadData() async throws -> [Results] {
    guard let url = URL(string: "https://itunes.apple.com/search?term=adele") else {
      throw APIError.failedURL
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    let result = try JSONDecoder().decode(APIData.self, from: data)
    
    return result.results
  }
  
}
