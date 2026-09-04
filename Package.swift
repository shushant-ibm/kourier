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
            url: "https://github.com/shushant-ibm/kourier/releases/download/v0.0.4/KourierIos.xcframework.zip",
            checksum: "58d0d5790cdaee91fb194714145bd6733ef96d72437626412ad44d8cabcbb38c"
        )
    ]
)
