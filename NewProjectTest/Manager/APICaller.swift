//
//  APICaller.swift
//  NewProjectTest
//
//  Created by iOS Wizard on 13/03/23.
//

import Foundation

enum APIError: Error {
  case invalidURL
  case invalidResponse
}

final class APICaller {
  
  static let shared = APICaller()
  
  private init() { }
  
  public func downloadData() async throws -> [Results] {
    guard let url = URL(string: "https://itunes.apple.com/search?term=adele") else {
      throw APIError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
      throw APIError.invalidResponse
    }
    
    let result = try JSONDecoder().decode(APIData.self, from: data)
    
    return result.results
  }
  
}
