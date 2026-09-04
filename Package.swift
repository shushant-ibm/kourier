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
            url: "https://github.com/shushant-ibm/kourier/releases/download/v0.0.6/KourierIos.xcframework.zip",
            checksum: "05ad5923e0a1522d8c6da6f1f28b43b5099d04b8fd8d79c3c91a8a0c56e20aed"
        )
    ]
)
