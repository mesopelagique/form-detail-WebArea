// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "4d-for-ios-form-detail-WebArea",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "___PRODUCT___", targets: ["___PRODUCT___"])
    ],
    dependencies: [
        .package(url: "https://github.com/4d-for-ios/QMobileAPI.git", .revision("HEAD")),
        .package(url: "https://github.com/4d-for-ios/QMobileUI.git", .revision("HEAD"))
    ],
    targets: [
        .target(name: "___PRODUCT___",
                dependencies: ["QMobileAPI", "QMobileUI"],
                path: "Sources",
                linkerSettings: [
                    .linkedFramework("WebKit")
                ])
    ]
)
