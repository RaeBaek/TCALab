import ProjectDescription

let project = Project(
    name: "Todos",
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
            name: "Todos",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.raehoon.TCALab.Todos",
            deploymentTargets: .iOS("17.0"),
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "ComposableArchitecture", condition: .none)
            ]
        ),
        .target(
            name: "TodosTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.raehoon.TCALab.TodosTests",
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: "Todos")]
        )
    ]
)
