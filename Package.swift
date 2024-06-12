// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HMNetworking",
    platforms: [
        .macOS(.v10_15),
        .tvOS(.v13),
        .iOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HMNetworking",
            targets: ["HMNetworking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.9.0")),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HMNetworking",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire")
            ]
        ),
        .testTarget(
            name: "HMNetworkingTests",
            dependencies: ["HMNetworking"]
        ),
    ]
)
