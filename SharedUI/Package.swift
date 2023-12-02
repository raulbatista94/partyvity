// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SharedUI",
            targets: ["SharedUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mac-cain13/R.swift.git", exact: "7.4.0"),
        .package(url: "https://github.com/realm/SwiftLint", exact: "0.53.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SharedUI",
            dependencies: [
                .product(name: "RswiftLibrary", package: "R.swift")
            ],
            resources: [
                .process("StyleGuide/Fonts/Resources")
            ],
            plugins: [
                .plugin(name: "RswiftGeneratePublicResources", package: "R.swift"),
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .testTarget(
            name: "SharedUITests",
            dependencies: ["SharedUI"]),
    ],
    swiftLanguageVersions: [.v5]
)
