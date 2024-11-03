package com.mrousavy.camera.core

import com.mrousavy.camera.core.types.Orientation

data class Photo(val path: String, val name: String, val width: Int, val height: Int, val orientation: Orientation, val isMirrored: Boolean)
