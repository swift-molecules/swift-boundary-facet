# Boundary Facet

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

The lossless projection between a box `Boundary.Edge` and its `Facet<2>` carrier for Swift — a per-carrier bridge that keeps the bare `Boundary.Edge` enum free of any `Facet` dependency.

---

## Quick Start

`Boundary.Edge` names a face of an axis-aligned 2D box (`top`, `left`, `bottom`, `right`); `Facet<2>` names a signed axis direction (an `Axis<2>` paired with a `Direction`). The two are the same four inhabitants seen through different vocabularies. This bridge adds the `.facet` projection and the `init(facet:)` inverse so an edge can travel as a facet — and back — without either type depending on the other.

```swift
import Boundary_Facet

// Project an edge onto its oriented facet (the +Y face).
let face = Boundary.Edge.top.facet      // Facet<2>(axis: .secondary, direction: .positive)

// The projection is lossless: recover the edge from any facet.
let edge = Boundary.Edge(facet: face)   // .top

// It commutes with "opposite": flipping the facet flips the edge.
Boundary.Edge.left.facet.opposite == Boundary.Edge.right.facet   // true
```

The axis convention is fixed: axis 0 = X = `.primary`, axis 1 = Y = `.secondary`, so `top` = +Y, `bottom` = −Y, `right` = +X, `left` = −X. Importing this module also re-exports `Boundary` and `Facet`, so `Boundary.Edge` and `Facet` are both in scope.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-molecules/swift-boundary-facet.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Boundary Facet", package: "swift-boundary-facet"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

One bridge target over the `Boundary.Edge` and `Facet<2>` carriers, plus a test-support re-export. The bridge lives in its own package so neither carrier package gains a dependency on the other.

| Product | Target | Purpose |
|---------|--------|---------|
| `Boundary Facet` | `Sources/Boundary Facet/` | Adds `Boundary.Edge.facet` and `Boundary.Edge(facet:)`, the lossless projection to and from `Facet<2>`. Re-exports `Boundary` and `Facet`. |
| `Boundary Facet Test Support` | `Tests/Support/` | Re-exports the bridge target for test consumers. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
