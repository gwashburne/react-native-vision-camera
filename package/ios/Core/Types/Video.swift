//
//  Video.swift
//  VisionCamera
//
//  Created by Marc Rousavy on 12.10.23.
//  Copyright © 2023 mrousavy. All rights reserved.
//

import AVFoundation
import Foundation

struct Video {
  /**
   URL to the temporary video file
   */
  var url: URL
  /**
   Duration of the recorded video (in seconds)
   */
  var duration: Double
  /**
   * The size of the video, in pixels.
   */
  var size: CGSize

  func toJSValue() -> NSDictionary {
    return [
      "path": url.absoluteString,
      "name": url.lastPathComponent,
      "duration": duration,
      "width": size.width,
      "height": size.height,
    ]
  }
}
