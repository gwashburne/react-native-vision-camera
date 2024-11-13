package com.mrousavy.camera.core.utils

import android.content.Context
import java.io.File

data class OutputFile(val context: Context, val directory: File, val extension: String, val name: String) {
  val file = File(directory, "$name$extension")

  init {
    try {
      file.createNewFile()
    } catch (e: Exception) {
      println("Error creating file")
    }

    if (directory.absolutePath.contains(context.cacheDir.absolutePath)) {
      // If this is a temp file (inside temp directory), the file will be deleted once the app closes
      file.deleteOnExit()
    }
  }
}
