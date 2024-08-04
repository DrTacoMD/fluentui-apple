// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "FluentUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v12),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "FluentUI",
            type: .static,
            targets: [
                "FluentUI"
            ]
        )
    ],
    targets: [
        .target(
            name: "FluentUI",
            dependencies: [
                .targetItem(name: "FluentUI_ios", condition: .when(platforms: [.iOS, .visionOS, .macCatalyst])),
                .targetItem(name: "FluentUI_macos", condition: .when(platforms: [.macOS]))
            ],
            path: "Sources/FluentUI"
        ),
        .target(
            name: "FluentUI_ios",
			dependencies: [
				.targetItem(name: "FluentUI_shared", condition: nil)
			],
            path: "Sources/FluentUI_iOS/FluentUI"
        ),
        .target(
            name: "FluentUI_macos",
            path: "Sources/FluentUI_macOS/FluentUI"
        ),
		.target(
			name: "FluentUI_shared"
		)
    ]
)
