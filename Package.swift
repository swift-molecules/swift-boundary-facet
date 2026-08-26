// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-boundary-facet",
    platforms: [.macOS(.v27), .iOS(.v27), .tvOS(.v27), .watchOS(.v27), .visionOS(.v27)],
    products: [
        .library(name: "Boundary Facet", targets: ["Boundary Facet"]),
        .library(
            name: "Boundary Facet Test Support",
            targets: ["Boundary Facet Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-boundary.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-facet.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Boundary Facet",
            dependencies: [
                .product(name: "Boundary", package: "swift-boundary"),
                .product(name: "Facet", package: "swift-facet"),
            ]
        ),
        .target(
            name: "Boundary Facet Test Support",
            dependencies: ["Boundary Facet"],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Boundary Facet Tests",
            dependencies: ["Boundary Facet", "Boundary Facet Test Support"]
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
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
    let package: [SwiftSetting] = []
    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
