//
//  FileUtils.swift
//  VisionCamera
//
//  Created by Marc Rousavy on 26.02.24.
//  Copyright © 2024 mrousavy. All rights reserved.
//

import AVFoundation
import CoreLocation
import Foundation
import UIKit

enum FileUtils {
  /**
   Writes Data to a temporary file.
   */
  private static func writeDataToFile(data: Data, file: URL) throws {
    do {
      if file.isFileURL {
        try data.write(to: file)
      } else {
        guard let url = URL(string: "file://\(file.absoluteString)") else {
          throw CameraError.capture(.createTempFileError(message: "Cannot create URL with file:// prefix!"))
        }
        try data.write(to: url)
      }
    } catch {
      throw CameraError.capture(.fileError(cause: error))
    }
  }

  static func writePhotoToFile(photo: AVCapturePhoto, metadataProvider: MetadataProvider, file: URL) throws {
    guard let data = photo.fileDataRepresentation(with: metadataProvider) else {
      throw CameraError.capture(.imageDataAccessError)
    }
    try writeDataToFile(data: data, file: file)
  }

  static func writeUIImageToFile(image: UIImage, file: URL, compressionQuality: CGFloat = 1.0) throws {
    guard let data = image.jpegData(compressionQuality: compressionQuality) else {
      throw CameraError.capture(.imageDataAccessError)
    }
    try writeDataToFile(data: data, file: file)
  }

  static var tempDirectory: URL {
    return FileManager.default.temporaryDirectory
  }

  static func createRandomFileName(withExtension fileExtension: String) -> String {
    //OG, don't change sig
      //Hopefully can remove this
    return UUID().uuidString + "." + fileExtension
  }

  static func createFileName(withExtension fileExtension: String, fileName: String?) -> String {
      if let fileName {
          return fileName + "." + fileExtension
      } else {
          return UUID().uuidString + "." + fileExtension
      }
  }

  static func getRandomFileName() -> String {
    UUID().uuidString
  }


  static private func generateCustomDirectory(directory: String) throws -> URL {

    // Prefix with file://
    let prefixedDirectory = directory.starts(with: "file:") ? directory : "file://\(directory)"
    // Create URL
    guard let url = URL(string: prefixedDirectory) else {
      throw CameraError.capture(.invalidPath(path: directory))
    }
      return url
  }
    
    static private func generateFilePath(directory: URL, fileExtension: String, fileName: String?) throws -> URL {
        let name = createFileName(withExtension: fileExtension, fileName: fileName)
        return directory.appendingPathComponent(name)
    }



  static func getFilePath(directory: URL, fileExtension: String) throws -> URL {
    // ********* OG, don't change sig **********
    // Random UUID filename
    let filename = createFileName(withExtension: fileExtension, fileName: nil)
    return directory.appendingPathComponent(filename)
  }

    
    
  static func getFilePath(customDirectory: String, fileExtension: String) throws -> URL {
    let url = try generateCustomDirectory(directory: customDirectory)
    return try generateFilePath(directory: url, fileExtension: fileExtension, fileName: nil)
  }
    
  static func getFilePath(customDirectory: String, fileExtension: String, fileName: String) throws -> URL {
    let url = try generateCustomDirectory(directory: customDirectory)
    return try generateFilePath(directory: url, fileExtension: fileExtension, fileName: fileName)
  }

  static func getFilePath(fileExtension: String) throws -> URL {
    return try generateFilePath(directory: tempDirectory, fileExtension: fileExtension, fileName: nil)
  }
    
  static func getFilePath(fileExtension: String, fileName: String) throws -> URL {
    return try generateFilePath(directory: tempDirectory, fileExtension: fileExtension, fileName: fileName)
  }
}
