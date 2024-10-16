package com.mrousavy.camera.core.types

import java.util.UUID
import android.content.Context
import com.facebook.react.bridge.ReadableMap
import com.mrousavy.camera.core.utils.FileUtils
import com.mrousavy.camera.core.utils.OutputFile

class RecordVideoOptions(
  val file: OutputFile,
  val videoCodec: VideoCodec,
  val videoBitRateOverride: Double?,
  val videoBitRateMultiplier: Double?,
  val name: String
) {

  companion object {
    fun fromJSValue(context: Context, map: ReadableMap): RecordVideoOptions {
      val directory = if (map.hasKey("path")) FileUtils.getDirectory(map.getString("path")) else context.cacheDir
      val name = if (map.hasKey("name")) map.getString("name") ?: UUID.randomUUID().toString() else UUID.randomUUID().toString()
      val fileType = if (map.hasKey("fileType")) VideoFileType.fromUnionValue(map.getString("fileType")) else VideoFileType.MOV
      val videoCodec = if (map.hasKey("videoCodec")) VideoCodec.fromUnionValue(map.getString("videoCodec")) else VideoCodec.H264
      val videoBitRateOverride = if (map.hasKey("videoBitRateOverride")) map.getDouble("videoBitRateOverride") else null
      val videoBitRateMultiplier = if (map.hasKey("videoBitRateMultiplier")) map.getDouble("videoBitRateMultiplier") else null

      val outputFile = OutputFile(context, directory, fileType.toExtension(), name)
      return RecordVideoOptions(outputFile, videoCodec, videoBitRateOverride, videoBitRateMultiplier, name)
    }
  }
}
