// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HapticKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "HapticKit",
            targets: ["HapticKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "HapticKit",
            dependencies: [],
            path: "Sources/HapticKit"),
        .testTarget(
            name: "HapticKitTests",
            dependencies: ["HapticKit"]),
    ]
)
