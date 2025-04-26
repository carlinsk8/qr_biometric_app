package com.example.qr_biometric_app.qrscan.presentation

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.foundation.border


@Composable
fun QrScannerOverlay() {
    Box(modifier = Modifier.fillMaxSize()) {
        // Marco para QR
        Box(
            modifier = Modifier
                .size(250.dp)
                .align(Alignment.Center)
                .border(3.dp, Color.White, RoundedCornerShape(12.dp))
        )
    }
}

