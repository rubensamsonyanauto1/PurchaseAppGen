// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PurchaseAppGen",
    products: [
        .executable(name: "skeleton", targets: ["Skeleton"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/Commander.git", .exact("0.9.0")),
        .package(url: "https://github.com/kylef/PathKit.git", .exact("1.0.0"))
    ],
    targets: [
        .target(
            name: "Skeleton",
            dependencies: ["SkeletonCore", "Commander"]),
        .target(
            name: "SkeletonCore",
            dependencies: ["PathKit", "SkeletonTemplates"]),
        .target(
            name: "SkeletonTemplates",
            dependencies: ["PathKit"])
    ]
)
