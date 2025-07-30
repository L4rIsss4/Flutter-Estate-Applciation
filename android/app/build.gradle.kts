import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

// ENV dosyasını yükle (.env dosyası proje kök dizininde olmalı!)
val localProperties = Properties().apply {
    val envFile = File(rootDir.parentFile, ".env")
    println("🔎 Denenen .env yolu: ${envFile.absolutePath}")
    if (envFile.exists()) {
        println("✅ .env dosyası bulundu.")
        load(FileInputStream(envFile))
    } else {
        println("❌ .env dosyası bulunamadı!")
    }
}
android {
    namespace = "com.example.emlak_project"
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
        applicationId = "com.example.emlak_project"
        minSdk = 23
        targetSdk = 33
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // 🔑 API KEY strings.xml'e ekleniyor
        resValue(
            "string",
            "google_maps_api_key",
            localProperties["GOOGLE_MAPS_API_KEY"]?.toString() ?: ""
        )
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
