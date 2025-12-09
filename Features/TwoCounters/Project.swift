import ProjectDescription

let project = Project(
    name: "TwoCounters",
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
            name: "TwoCounters",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.raehoon.TCALab.TwoCounters",
            deploymentTargets: .iOS("17.0"),
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Counter", path: "../Counter"),
                .external(name: "ComposableArchitecture", condition: .none)
            ]
        ),
        .target(
            name: "TwoCountersTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.raehoon.TCALab.TwoCountersTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: "TwoCounters")]
        )
    ]
)
