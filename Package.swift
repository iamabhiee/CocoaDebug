// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "CocoaDebug",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "CocoaDebug", targets: ["CocoaDebug"]),
    ],
    targets: [
        .target(
            name: "CocoaDebug",
            path: "Sources",
            exclude: [
                "Info.plist"
            ],
            resources: [
                .process("Assets"),
                .process("**/*.xib"),
                .process("**/*.storyboard"),
                .process("**/*.png")
            ],
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath(".")
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
