plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // Specify the required NDK version for compatibility with audio plugins
    ndkVersion = "27.0.12077973"
    // Set NDK version to resolve compatibility with audio plugins
    ndkVersion = "27.0.12077973"
    ndkVersion = "27.0.12077973"
    // Added to satisfy build requirement for plugins needing a specific NDK version
    ndkVersion = "27.0.12077973"
    // Specify NDK version for build stability and compatibility
    ndkVersion = "27.0.12077973"
    // Specify NDK version required for just_audio, audio_session, and path_provider_android plugins
    ndkVersion = "27.0.12077973"
    namespace = "com.example.mobile_app_frontend"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.mobile_app_frontend"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
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
}

flutter {
    source = "../.."
}
