// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Kourier",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "KourierIos",
            targets: ["KourierIos"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "KourierIos",
            url: "https://github.com/shushant-ibm/kourier/releases/download/v0.0.1/KourierIos.xcframework.zip",
            checksum: "d57c9062e0468554888373af1f7080a0993ad3590447dbf318335741959043b0"
        )
    ]
)
