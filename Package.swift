// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DoubleInputFormatter",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "DoubleInputFormatter",
            targets: ["DoubleInputFormatter"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DoubleInputFormatter"),
        .testTarget(
            name: "DoubleInputFormatterTests",
            dependencies: ["DoubleInputFormatter"]),
    ]
)
