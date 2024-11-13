package com.mrousavy.camera.core.types

import android.content.Context
import com.facebook.react.bridge.ReadableMap
import com.mrousavy.camera.core.utils.FileUtils
import com.mrousavy.camera.core.utils.OutputFile
import java.util.UUID

data class TakePhotoOptions(val file: OutputFile, val flash: Flash, val enableShutterSound: Boolean) {

  companion object {
    fun fromJS(context: Context, map: ReadableMap): TakePhotoOptions {
      val flash = if (map.hasKey("flash")) Flash.fromUnionValue(map.getString("flash")) else Flash.OFF
      val enableShutterSound = if (map.hasKey("enableShutterSound")) map.getBoolean("enableShutterSound") else false
      val directory = if (map.hasKey("path")) FileUtils.getDirectory(map.getString("path")) else context.cacheDir
      val name = if (map.hasKey("name")) map.getString("name") ?: UUID.randomUUID().toString() else UUID.randomUUID().toString()

      val outputFile = OutputFile(context, directory, ".jpg", name)
      return TakePhotoOptions(outputFile, flash, enableShutterSound)
    }
  }
}
