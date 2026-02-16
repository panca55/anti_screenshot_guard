// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "anti_screenshot_guard",
    platforms: [
        .iOS("11.0")
    ],
    products: [
        .library(
            name: "anti-screenshot-guard",
            targets: ["anti_screenshot_guard"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "anti_screenshot_guard",
            dependencies: [],
            path: "../Classes"
        )
    ]
)