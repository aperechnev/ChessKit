// swift-tools-version:6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChessKit",
    products: [
        .library(
            name: "ChessKit",
            targets: ["ChessKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "ChessKit",
            dependencies: ["libchess"]
        ),
        .testTarget(
            name: "ChessKitTests",
            dependencies: ["ChessKit"]
        ),
        .target(
            name: "libchess"
        ),
        .testTarget(
            name: "libchessTests",
            dependencies: ["libchess"]
        ),
    ]
)
