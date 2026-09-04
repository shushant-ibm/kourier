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
            url: "https://github.com/shushant-ibm/kourier/releases/download/v0.0.2/KourierIos.xcframework.zip",
            checksum: "9fd159b73991bae63b259d23c85cd498d921b4a6c3ae3829636309a6a22092b6"
        )
    ]
)
