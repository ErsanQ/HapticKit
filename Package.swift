// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "HapticKit",
    platforms: [
        .iOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "HapticKit",
            targets: ["HapticKit"]
        ),
    ],
    targets: [
        .target(
            name: "HapticKit",
            path: "Sources/HapticKit",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "HapticKitTests",
            dependencies: ["HapticKit"],
            path: "Tests/HapticKitTests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
