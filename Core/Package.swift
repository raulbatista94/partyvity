// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint", exact: "0.53.0"),
        .package(url: "https://github.com/CombineCommunity/CombineExt.git", exact: "1.8.1")
    ],
    targets: [
        .target(
            name: "Core",
            path: "Sources",
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency=targeted")
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
