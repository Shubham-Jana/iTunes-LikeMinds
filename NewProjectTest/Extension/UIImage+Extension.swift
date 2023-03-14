//
//  UIImage+Extension.swift
//  NewProjectTest
//
//  Created by iOS Wizard on 14/03/23.
//

import UIKit

extension UIImage {
  public func imageData(url: URL) async throws -> Data {
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
  }
}
