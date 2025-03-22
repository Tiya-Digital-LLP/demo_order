plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.demoorder"
    compileSdk = 35
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
        applicationId = "com.example.demoorder"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            storeFile = file("/Users/chandrakantviradiya/Documents/FlutterDev/plastic4tradeNew/android/app/keystore.jks")
            storePassword = "123456" 
            keyAlias = "key0"
            keyPassword = "123456"
        }
    }

    buildTypes {
        getByName("release") {
                isShrinkResources = false
                isMinifyEnabled = false
                proguardFiles(
                    getDefaultProguardFile("proguard-android.txt"),
                    "proguard-rules.pro"
                )
            }
        }
}

flutter {
    source = "../.."
}
