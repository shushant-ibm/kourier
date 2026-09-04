# Kourier 🚀

[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-3DDC84.svg)](https://github.com/shushant-ibm/kourier)
[![Kotlin](https://img.shields.io/badge/Kotlin-Multiplatform-7F52FF.svg)](https://kotlinlang.org)
[![SPM](https://img.shields.io/badge/Swift_Package_Manager-compatible-FA7343.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

**Enterprise In-App Network & Telemetry Inspection SDK for Android & iOS**  
*Chucker equivalent built from the ground up for modern mobile engineering.*

Kourier runs **directly inside your mobile application** — requiring zero desktop companion apps, zero proxy certificates, and zero VPN configurations.

---

## 📱 Quick Integration

### 🤖 Android Integration (Zero Credentials Required)

Kourier Android SDK is distributed via a public zero-credential Maven repository hosted on GitHub.

#### 1. Add Maven Repository (`settings.gradle.kts`)

```kotlin
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        // Kourier Public Maven Repository (No token / credentials needed)
        maven { url = uri("https://raw.githubusercontent.com/shushant-ibm/kourier/main/repo") }
    }
}
```

#### 2. Add Dependencies (`app/build.gradle.kts`)

```kotlin
dependencies {
    // Debug builds: Full in-app inspector UI, floating triggers, and interceptors
    debugImplementation("dev.shushant.kourier:kourier-android:0.0.1")

    // Release builds: Zero-cost pass-through stubs (0KB background services, stripped bytecode)
    releaseImplementation("dev.shushant.kourier:kourier-noop:0.0.1")
}
```

#### 3. Initialize in `Application.onCreate`

```kotlin
import android.app.Application
import dev.shushant.kourier.android.Kourier

class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()

        Kourier.init(this) {
            maxPayloadSize(500 * 1024L) // 500 KB limit per payload
            maxRetentionCount(1000)      // Retain last 1,000 transactions
            retentionPeriodDays(3)       // Auto-prune requests older than 3 days

            // Mask sensitive credentials
            redactHeaders("Authorization", "Cookie", "X-Api-Key")
            redactPayloadKeys("password", "token", "secret", "credit_card")

            // In-app triggers
            enableShakeGesture(true)     // Shake device to open
            enableFloatingBubble(true)   // Draggable floating bug overlay
            enableNotification(true)     // Ongoing system tray notification
        }
    }
}
```

#### 4. Wire Interceptors

**OkHttp:**
```kotlin
import dev.shushant.kourier.interceptor.okhttp.KourierOkHttpInterceptor

val okHttpClient = OkHttpClient.Builder()
    .addInterceptor(KourierOkHttpInterceptor())
    .build()
```

**Ktor Client (3.x):**
```kotlin
import dev.shushant.kourier.interceptor.ktor.KourierKtorPlugin

val ktorClient = HttpClient(OkHttp) {
    install(KourierKtorPlugin)
}
```

---

### 🍎 iOS Integration (Swift Package Manager)

Kourier iOS is distributed as a pre-compiled binary XCFramework via **Swift Package Manager**.

#### 1. Add Package via Xcode
1. In Xcode, navigate to **File > Add Package Dependencies...**
2. Enter the repository URL: `https://github.com/shushant-ibm/kourier.git`
3. Dependency Rule: **Up to Next Major from 0.0.1** (or exact version `0.0.1`).
4. Select the **`KourierIos`** package product for your app target.

*Or add to your `Package.swift`:*
```swift
dependencies: [
    .package(url: "https://github.com/shushant-ibm/kourier.git", from: "0.0.1")
]
```

#### 2. Initialize in `AppDelegate.swift` or SwiftUI `@main App`

```swift
import UIKit
import KourierIos

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // 1. Initialize Kourier
        Kourier.shared.doInit { config in
            config.maxPayloadSize(bytes: 500 * 1024)
            config.maxRetentionCount(count: 1000)
            config.redactHeaders(headers: ["Authorization", "Cookie"])
            config.redactPayloadKeys(keys: ["password", "token", "secret"])
            config.enableShakeGesture(enable: true)
        }

        // 2. Register global URLSession interception
        KourierURLSessionConfiguration.shared.install()

        return true
    }
}
```

#### 3. Custom `URLSessionConfiguration` (Alamofire / Moya)

```swift
let configuration = URLSessionConfiguration.default
KourierURLSessionConfiguration.shared.enable(configuration: configuration)
let session = URLSession(configuration: configuration)
```

#### 4. Required iOS Configuration (`Info.plist`)

Compose Multiplatform requires the following key in your iOS host application `Info.plist`:
```xml
<key>CADisableMinimumFrameDurationOnPhone</key>
<true/>
```

---

## ✨ Features & Capabilities

- 🌗 **Dual-Theme Studio Aesthetic:** Obsidian Slate (Dark) and Studio Daylight (Light) with dynamic switching.
- 📱 **Adaptive UI:** Responsive Split-Pane Master-Detail on iPad/Tablets/Foldables and single-column on phones.
- 📤 **Multi-Format Sharing:**
  - 💬 **Plain Text:** Formatted for instant sharing into **WhatsApp**, **Slack**, **Telegram**, and **Apple Notes**.
  - 📄 **Text File (.txt):** Document attachment report with complete request/response telemetry.
  - 📦 **HAR 1.2 Archive (.har):** Import into Proxyman, Charles Proxy, Postman, and Chrome DevTools.
  - 🌐 **cURL Command:** Executable terminal snippet.
- 🛡️ **Payload Safety:** Configurable body caps with truncation warnings and recursive JSON/header redaction.
- ⚡ **Zero-Overhead Release Stub (`kourier-noop`):** Safe for production release builds.

---

## 📄 License
Apache License 2.0. Copyright © 2026 Shushant Tiwari.
