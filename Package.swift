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
            url: "https://github.com/shushant-ibm/kourier/releases/download/v0.0.9/KourierIos.xcframework.zip",
            checksum: "f4dabed28b73c5696066c3246ef6299f13cb4e4f0eecc4b18964ee8a7e087922"
        )
    ]
)
