// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChessKit",
    products: [
        .library(
            name: "ChessKit",
            targets: ["ChessKit"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ChessKit",
            dependencies: []
        ),
        .testTarget(
            name: "ChessKitTests",
            dependencies: ["ChessKit"]
        ),
    ]
)
