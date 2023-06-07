// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MusicAPI",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "MusicAPI",
            targets: ["MusicAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.6.1"))
    ],
    targets: [
        .target(
            name: "MusicAPI",
            dependencies: ["Alamofire"])
    ]
)
