// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "SbjGauge",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .watchOS(.v9),
        .tvOS(.v16)
    ],
    products: [
        .library(
            name: "SbjGauge",
            targets: ["SbjGauge"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SbjGauge",
            dependencies: []),
        .testTarget(
            name: "SbjGaugeTests",
            dependencies: ["SbjGauge"]),
    ]
)
