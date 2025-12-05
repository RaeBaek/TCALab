import ProjectDescription

let project = Project(
    name: "Counter",
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
            name: "Counter",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.raehoon.TCALab.Counter",
            deploymentTargets: .iOS("17.0"),
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture", condition: .none)
            ]
        ),
        .target(
            name: "CounterTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.raehoon.TCALab.CounterTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: "Counter")]
        ),
    ]
)
