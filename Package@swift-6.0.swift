// swift-tools-version:6.0

import PackageDescription

extension String {
    static let webFoundation: Self = "WebFoundation"
}

extension Target.Dependency {
    static var webFoundation: Self { .target(name: .webFoundation) }
}

extension Target.Dependency {
    static var builders: Self { .product(name: "Builders", package: "swift-builders") }
    static var foundationExtensions: Self { .product(name: "FoundationExtensions", package: "swift-foundation-extensions") }
    static var emailAddress: Self { .product(name: "EmailAddress", package: "swift-emailaddress-type") }
    static var dateParsing: Self { .product(name: "DateParsing", package: "swift-date-parsing") }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
    static var domain: Self { .product(name: "Domain", package: "swift-domain-type") }
    static var jwt: Self { .product(name: "JWT", package: "swift-jwt") }
    static var logging: Self { .product(name: "Logging", package: "swift-log") }
    static var parsing: Self { .product(name: "Parsing", package: "swift-parsing") }
    static var sitemap: Self { .product(name: "Sitemap", package: "swift-sitemap") }
    static var html: Self { .product(name: "HTML", package: "swift-html") }
    static var htmlTestSupport: Self { .product(name: "PointFreeHTMLTestSupport", package: "pointfree-html") }
    static var unixEpoch: Self { .product(name: "UnixEpochParsing", package: "swift-date-parsing") }
    static var urlFormCoding: Self { .product(name: "URLFormCoding", package: "swift-url-form-coding") }
    static var urlFormCodingURLRouting: Self { .product(name: "URLFormCodingURLRouting", package: "swift-url-form-coding-url-routing") }
    static var urlMultipartFormCodingURLRouting: Self { .product(name: "URLMultipartFormCodingURLRouting", package: "swift-url-multipart-form-coding-url-routing") }
    static var urlRouting: Self { .product(name: "URLRouting", package: "swift-url-routing") }
}

let package = Package(
    name: "swift-web-foundation",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: .webFoundation,
            targets: [
                .webFoundation,
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/pointfree-html", from: "2.0.0"),
        .package(url: "https://github.com/coenttb/swift-builders", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-html", from: "0.1.2"),
        .package(url: "https://github.com/coenttb/swift-date-parsing", from: "0.1.0"),
        .package(url: "https://github.com/coenttb/swift-foundation-extensions", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-jwt", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-emailaddress-type", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-domain-type", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-sitemap", from: "0.0.1"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.1.5"),
        .package(url: "https://github.com/pointfreeco/swift-parsing.git", from: "0.14.1"),
        .package(url: "https://github.com/coenttb/swift-url-form-coding", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-url-form-coding-url-routing", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-url-multipart-form-coding-url-routing", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: .webFoundation,
            dependencies: [
                .builders,
                .dateParsing,
                .foundationExtensions,
                .jwt,
                .html,
                .emailAddress,
                .domain,
                .parsing,
                .sitemap,
                .urlFormCoding,
                .urlFormCodingURLRouting,
                .urlMultipartFormCodingURLRouting,
                .unixEpoch
            ]
        ),
        .testTarget(
            name: .webFoundation.tests,
            dependencies: [.webFoundation, .dependenciesTestSupport, .htmlTestSupport]
        )
    ],
    swiftLanguageModes: [.v6]
)

extension String { var tests: Self { self + " Tests" } }
