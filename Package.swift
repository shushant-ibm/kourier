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
            url: "https://github.com/shushant-ibm/kourier/releases/download/v0.0.3/KourierIos.xcframework.zip",
            checksum: "ed65118045dd35e37f7af7bc6564b2781a0fe0d6ee70a6b7a41c8b1086d9ff22"
        )
    ]
)
