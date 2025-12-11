import ProjectDescription

let project = Project(
    name: "Animation",
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
            name: "Animation",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.raehoon.TCALab.Animation",
            deploymentTargets: .iOS("17.0"),
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture", condition: .none)
            ]
        ),
        .target(
            name: "AnimationTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.raehoon.TCALab.AnimationTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: "Animation")]
        )
    ]
)
