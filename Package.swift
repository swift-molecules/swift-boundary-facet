// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-boundary-facet-primitives",
    platforms: [.macOS(.v27), .iOS(.v27), .tvOS(.v27), .watchOS(.v27), .visionOS(.v27)],
    products: [
        .library(name: "Boundary Facet Primitives", targets: ["Boundary Facet Primitives"]),
        .library(
            name: "Boundary Facet Primitives Test Support",
            targets: ["Boundary Facet Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-boundary-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-facet-primitives.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Boundary Facet Primitives",
            dependencies: [
                .product(name: "Boundary Primitives", package: "swift-boundary-primitives"),
                .product(name: "Facet Primitives", package: "swift-facet-primitives"),
            ]
        ),
        .target(
            name: "Boundary Facet Primitives Test Support",
            dependencies: ["Boundary Facet Primitives"],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Boundary Facet Primitives Tests",
            dependencies: ["Boundary Facet Primitives", "Boundary Facet Primitives Test Support"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]
    let package: [SwiftSetting] = []
    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
