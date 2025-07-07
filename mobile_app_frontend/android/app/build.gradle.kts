plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    // Specify NDK version required for plugin compatibility
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
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Signing with debug keys for now, for ease of debugging
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // PUBLIC_INTERFACE
    // Correct output filename for the release build using Kotlin DSL for AGP 8.x
    applicationVariants.configureEach {
        if (buildType.name == "release") {
            outputs.configureEach {
                if (this is com.android.build.gradle.internal.api.ApkVariantOutputImpl) {
                    this.outputFileName = "app-release.apk"
                }
            }
        }
    }
}

flutter {
    source = "../.."
}
