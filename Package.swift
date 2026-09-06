// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Kourier",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Kourier",
            targets: ["KourierSwift", "KourierIos"]
        ),
        .library(
            name: "KourierIos",
            targets: ["KourierIos"]
        ),
    ],
    targets: [
        .target(
            name: "KourierSwift",
            dependencies: [
                "KourierIos"
            ],
            path: "Sources/KourierSwift",
            linkerSettings: [
                .linkedLibrary("sqlite3"),
                .linkedLibrary("c++")
            ]
        ),
        .binaryTarget(
            name: "KourierIos",
            url: "https://github.com/shushant-ibm/kourier/releases/download/v0.0.10/KourierIos.xcframework.zip",
            checksum: "c86987dbd50eff76d7c3bd3eb84ff0f81caae4c940fa08b5a82549e7c964783f"
        )
    ]
)
