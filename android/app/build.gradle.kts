plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    
    namespace = "com.example.qr_biometric_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.qr_biometric_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
    
    buildFeatures {
        compose = true
    }
    
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.4"
    }

    sourceSets["main"].kotlin.srcDir("src/main/kotlin")

}

flutter {
    source = "../.."
}

dependencies {

    // Biometric
    implementation("androidx.biometric:biometric:1.1.0")

     // CameraX
     implementation("androidx.camera:camera-core:1.3.2")
     implementation("androidx.camera:camera-camera2:1.3.2")
     implementation("androidx.camera:camera-lifecycle:1.3.2")
     implementation("androidx.camera:camera-view:1.3.2")
     implementation("androidx.camera:camera-extensions:1.3.2")
     implementation("androidx.camera:camera-video:1.3.2")
 
    // Compose
    implementation("androidx.activity:activity-compose:1.7.2")
    implementation("androidx.compose.ui:ui:1.5.4")
    implementation("androidx.compose.material3:material3:1.1.2")
    implementation("androidx.compose.ui:ui-tooling-preview:1.5.4")
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.6.2")
    implementation("androidx.lifecycle:lifecycle-viewmodel-compose:2.6.2")
    implementation("androidx.compose.runtime:runtime-livedata:1.5.4")
    implementation("androidx.compose.foundation:foundation:1.5.4")
    implementation("androidx.compose.material:material:1.5.4")
 
     // Barcode scanning (Google ML Kit)
     implementation("com.google.mlkit:barcode-scanning:17.2.0")
 
     // Lifecycle
     implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.6.2")
     implementation("androidx.lifecycle:lifecycle-viewmodel-compose:2.6.2")

    
}

