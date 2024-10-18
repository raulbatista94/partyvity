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
        .package(url: "https://github.com/CombineCommunity/CombineExt.git", exact: "1.8.1"), // TODO: Consider removing
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: ["Swinject"],
            path: "Sources",
            resources: [
                .process("Common/words.json")
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency=targeted")
            ]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
