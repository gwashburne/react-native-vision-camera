//
//  TakeSnapshotOptions.swift
//  VisionCamera
//
//  Created by Marc Rousavy on 25.07.24.
//

import AVFoundation
import Foundation

struct TakeSnapshotOptions {
  var path: URL
  var name: String
  var quality: Double = 1.0

  init(fromJSValue dictionary: NSDictionary) throws {
    // Quality
    if let customQuality = dictionary["quality"] as? Double {
      quality = customQuality / 100.0
    }
    
    // Custom file name
    if let customName = dictionary["name"] as? String {
      name = customName
    } else {
      name = FileUtils.getRandomFileName()
    }

    // Custom Path
    if let customPath = dictionary["path"] as? String {
      path = try FileUtils.getFilePath(customDirectory: customPath, fileExtension: "jpg", fileName: name)
    } else {
      path = try FileUtils.getFilePath(fileExtension: "jpg", fileName: name)
    }
  }
}
