# Kourier 🚀

[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-3DDC84.svg)](https://github.com/shushant-ibm/kourier)
[![Kotlin](https://img.shields.io/badge/Kotlin-Multiplatform-7F52FF.svg)](https://kotlinlang.org)
[![SPM](https://img.shields.io/badge/Swift_Package_Manager-compatible-FA7343.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)

**Enterprise-grade in-app network inspection and telemetry toolkit for Android & iOS.**  
Inspect, debug, and share HTTP/HTTPS traffic directly on-device in real-time — with zero proxies, zero SSL certificates, and zero desktop tethering.

---

## 💡 Why Kourier?

Modern mobile teams waste hours debugging network issues in the field, configuring proxy certificates, setting up VPN tunnels, and diagnosing failed API responses on QA builds. **Kourier solves t[...]

```
┌────────────────────────────────────────────────────────────────[...]
│                                 KOURIER SDK                                     │
├──────────────────────────┬──────────────────────────┬──────────[...]
│   🚀 Zero Configuration   │   📱 On-Device Inspector │   🛡️ Privacy & Security   │
│   No proxy certificates  │   Native Compose UI      │   Automatic token &       │
│   No Mac/PC tethering    │   Dark / Light themes    │   credential redaction    │
│   No VPN profiles        │   Phone & Tablet split   │   Configurable caps       │
├──────────────────────────┼──────────────────────────┼──────────[...]
│   📤 1-Tap Multi-Export  │   ⚡ Zero Release Cost   │   🌐 Universal Clients    │
│   WhatsApp, Slack format │   kourier-noop stub      │   OkHttp, Ktor 3.x,       │
│   HAR 1.2 for Proxyman   │   0 KB background runs   │   URLSession, Alamofire   │
│   Executable cURL        │   Stripped bytecode      │   Moya                    │
└──────────────────────────┴──────────────────────────┴──────────[...]
```

### 🔑 Key Advantages

- 🚫 **No Proxies, No VPNs, No Root Certificates:** Debug live traffic on physical devices during field tests, remote client demos, and QA runs without network configurations or SSL pinning byp[...]
- 📱 **True Multiplatform Uniformity:** Single unified inspection mental model and telemetry format across Android and iOS.
- 🎨 **Studio-Grade Adaptive UI:** Designed with Compose Multiplatform featuring Obsidian Slate (Dark) and Studio Daylight (Light) themes, real-time query/method filtering, JSON syntax formatti[...]
- 📤 **Instant Bug Reporting & Exporting:**
  - 💬 **Formatted Plain Text:** Designed for instant copy-pasting into **WhatsApp**, **Slack**, **Telegram**, or **Apple Notes**.
  - 📄 **Diagnostic Report (.txt):** Complete request/response telemetry attachment.
  - 📦 **HAR 1.2 Archive (.har):** Import directly into Proxyman, Charles Proxy, Chrome DevTools, or Postman.
  - 🌐 **cURL Snippet:** 1-tap copy to replay the exact request from terminal.
- 🛡️ **Enterprise Privacy & Security:** Recursive data masker automatically scrubs sensitive headers (`Authorization`, `Cookie`, `X-Api-Key`) and JSON keys (`password`, `token`, `[...]
- ⚡ **Zero-Overhead Release Builds:** Ship with `kourier-noop` in release builds for zero memory footprint, stripped bytecode, and no background services.

---

## 📱 Quick Integration

### 🍎 iOS Integration (Swift Package Manager)

Kourier iOS is distributed as a pre-compiled binary XCFramework supporting **both physical iOS devices and iOS Simulators**.

#### 1. Add Package Dependency
In Xcode: **File > Add Package Dependencies...**
- **Repository URL:** `https://github.com/shushant-ibm/kourier.git`
- **Dependency Rule:** `Up to Next Major` from `0.0.9` (or exact version `0.0.9`)
- Add **`KourierIos`** to your target.

*Or via `Package.swift`:*
```swift
dependencies: [
    .package(url: "https://github.com/shushant-ibm/kourier.git", from: "0.0.9")
]
```

#### 2. Initialize in `AppDelegate.swift` / `@main App`

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
            config.redactHeaders(headers: ["Authorization", "Cookie", "X-Api-Key"])
            config.redactPayloadKeys(keys: ["password", "token", "secret", "credit_card"])
            config.enableShakeGesture(enable: true)
        }

        // 2. Intercept global URLSession
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

#### 4. Required iOS `Info.plist` Configuration

Compose Multiplatform requires the following key in your iOS host application `Info.plist`:
```xml
<key>CADisableMinimumFrameDurationOnPhone</key>
<true/>
```

---

### 🤖 Android Integration (Zero Credentials Required)

Kourier Android is hosted as a public Maven repository on GitHub. **No Personal Access Tokens (PAT), tokens, or credentials are required.**

#### 1. Add Public Maven Repository (`settings.gradle.kts`)

```kotlin
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        // Kourier Public Maven Repository (Zero credentials / No PAT needed)
        maven { url = uri("https://raw.githubusercontent.com/shushant-ibm/kourier/mvn-repo") }
    }
}
```

#### 2. Add Dependencies (`app/build.gradle.kts`)

```kotlin
dependencies {
    // Debug builds: Full in-app inspector UI, floating bubble, notification, & interceptors
    debugImplementation("dev.shushant.kourier:kourier-android:0.0.9")

    // Release builds: Zero-cost pass-through stubs (0KB background services, stripped bytecode)
    releaseImplementation("dev.shushant.kourier:kourier-noop:0.0.9")
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

## ⚙️ Configuration Options

| Option | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `maxPayloadSize` | `Long` / `Int` | `250 KB` | Maximum bytes stored per body payload before truncation |
| `maxRetentionCount` | `Int` | `500` | Maximum number of transactions preserved in local SQLite storage |
| `retentionPeriodDays`| `Int` | `7` | Auto-pruning threshold for aged requests |
| `redactHeaders` | `List<String>` | `Authorization`, `Cookie` | Headers whose values are obfuscated with `***REDACTED***` |
| `redactPayloadKeys` | `List<String>` | `password`, `token`, `secret` | JSON keys recursively masked in request/response bodies |
| `enableShakeGesture` | `Boolean` | `true` | Opens Kourier inspector when device is physically shaken |
| `enableFloatingBubble`| `Boolean` | `true` | Renders a draggable floating overlay button on screen |
| `enableNotification` | `Boolean` | `true` (Android) | Displays ongoing transaction notification with quick action |

---

## 📄 License

Apache License 2.0. Copyright © 2026 Shushant Tiwari.
