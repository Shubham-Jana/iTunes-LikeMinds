//
//  ViewModel.swift
//  NewProjectTest
//
//  Created by iOS Wizard on 13/03/23.
//

import Foundation

struct CellModel {
  let description: String
  let collectionPrice: Double
  let artistName: String
  let artworkUrl60: URL?
}

class ViewModel {
  var model = [CellModel]()
  var imageData: Data? = nil
 
  public func getData() async {
    do {
      let data = try await APICaller.shared.downloadData()
      model = data.compactMap({
        CellModel(description: $0.description ?? "Empty",
                  collectionPrice: $0.collectionPrice ?? 0.0,
                  artistName: $0.artistName,
                  artworkUrl60: $0.artworkUrl60 )
      })
    } catch {
      print(error)
    }
  }

}
