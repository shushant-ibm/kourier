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
            url: "https://github.com/shushant-ibm/kourier/releases/download/v0.0.7/KourierIos.xcframework.zip",
            checksum: "39988ec47e06d248447cfb67ccfa62c2724de4b21a20d17708c7fcf39bb382d8"
        )
    ]
)
