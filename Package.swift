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
            url: "https://github.com/shushant-ibm/kourier/releases/download/v0.0.8/KourierIos.xcframework.zip",
            checksum: "a5afd17e060c641bf49a044717735868b69a8a3245a7997a0c18ec5e9934e573"
        )
    ]
)
