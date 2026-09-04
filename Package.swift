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
            checksum: "04e04719e6ab41f9e1433c83731dfcf9dc8cd809d5744291e54c6445ad3e8fb7"
        )
    ]
)
