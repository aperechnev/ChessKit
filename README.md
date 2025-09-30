# ChessKit

[![docs badge](https://raw.githubusercontent.com/aperechnev/ChessKit/develop/docs/badge.svg)](https://aperechnev.github.io/ChessKit/) ![Tests](https://github.com/aperechnev/ChessKit/workflows/Tests/badge.svg) ![](https://img.shields.io/github/license/aperechnev/ChessKit) [![ChessKit pod](https://img.shields.io/cocoapods/v/ChessKit)](https://cocoapods.org/pods/ChessKit)

A lightweight and fast chess framework written in Swift.

ChessKit is a core library used in [Ladoga](https://lichess.org/@/ladoga_engine) chess engine.

## Installation

ChessKit framework is avalable for installation via Swift Package Manager.

Add a dependency to the Xcode project by linking to `https://github.com/aperechnev/ChessKit`, or directly in your `Package.swift` file:

```Swift
import PackageDescription

let package = Package(
    name: "MyPackage",
    platforms: [
        .macOS(.v10_12),
    ],
    dependencies: [
        .package(url: "https://github.com/aperechnev/ChessKit.git", from: "1.3.7"),
    ],
    targets: [
        .target(name: "MyPackage", dependencies: ["ChessKit"]),
    ]
)
```

## Getting Started

ChessKit is well covered by [documentation](https://aperechnev.github.io/ChessKit/). However, here you can find an example that describes how to start working with ChessKit.

```Swift
import ChessKit

let fenSerializer = FenSerialization()
let italianGameFen = "r1bqk1nr/pppp1ppp/2n5/2b1p3/2B1P3/5N2/PPPP1PPP/RNBQK2R w KQkq - 4 4"
let italianGamePosition = fenSerializer.deserialize(fen: italianGameFen)
let game = Game(position: italianGamePosition)

print("Number of available moves: \(game.legalMoves.count)")

game.make(move: "b2b4")
let evansGambitFen = fenSerializer.serialize(position: game.position)
print("Evans gambit fen: \(evansGambitFen)")

game.make(move: Move(string: "c5b4"))
let evansGambitAcceptedFen = fenSerializer.serialize(position: game.position)
print("Evans gambit accepted fen: \(evansGambitAcceptedFen)")

print("List of moves in game: \(game.movesHistory)")
print("List of pieces on board: \(game.position.board.enumeratedPieces())")
```

## Versioning

We use [semantic versioning](https://semver.org).

## License

ChessKit is released under the MIT license. See LICENSE for details.
