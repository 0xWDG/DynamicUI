// swift-tools-version: 5.9.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DynamicUI",
    platforms: [
        .iOS(.v15), // Untested.
        .macOS(.v12), // Tested.
        .tvOS(.v13), // Untested.
        .watchOS(.v6), // Untested.
        .macCatalyst(.v15) // Untested.
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DynamicUI",
            targets: ["DynamicUI"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DynamicUI"),
        .testTarget(
            name: "DynamicUITests",
            dependencies: ["DynamicUI"])
    ]
)
