import ProjectDescription

let project = Project(
    name: "TCALab",
    settings: .settings(
        base: [
            "SWIFT_VERSION": "5.10",
            "DEVELOPMENT_TEAM": "DD66GTY4AT",
            "CODE_SIGN_STYLE": "Automatic"
        ],
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Release")
        ]
    ),
    targets: [
        .target(
            name: "TCALab",
            destinations: .iOS,
            product: .app,
            bundleId: "com.raehoon.TCALab",
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleDisplayName": "TCALab",
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
        ),
        .target(
            name: "TCALabTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.raehoon.TCALabTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: "TCALab")]
        ),
    ]
)
