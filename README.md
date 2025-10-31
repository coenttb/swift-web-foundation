# swift-web-foundation

[![CI](https://github.com/coenttb/swift-web-foundation/workflows/CI/badge.svg)](https://github.com/coenttb/swift-web-foundation/actions/workflows/ci.yml)
![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

A consolidated Swift package providing unified access to essential web development libraries through a single import.

## Overview

`swift-web-foundation` is a glue library that re-exports a curated collection of Swift packages for type-safe web development. Rather than managing multiple dependencies individually, this foundation provides consolidated access to web standards, parsing, routing, content generation, and domain modeling tools.

The package acts as a dependency consolidation layer, allowing you to import one module and gain access to 15+ specialized libraries covering email validation, JWT handling, HTML generation, URL routing, form encoding, date parsing, and more.

## Features

- **Single Import**: Access 15+ specialized packages through one `import WebFoundation` statement
- **Type Safety**: All included libraries provide compile-time guarantees for web standards
- **Standard Compliance**: RFC-compliant implementations for email (RFC 5322/6531), JWT (RFC 7519), dates (RFC 2822/5322), and multipart forms (RFC 7578)
- **Dependency Consolidation**: Access all functionality through a single package dependency
- **Convenience Extensions**: Provides `ParserPrinter.href(for:)` extension for generating type-safe links from routes

## Installation

Add `swift-web-foundation` to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/swift-web-foundation.git", branch: "main")
]
```

Then add it to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "WebFoundation", package: "swift-web-foundation")
    ]
)
```

## Quick Start

Import the foundation and access all included functionality:

```swift
import WebFoundation

// Email validation with RFC compliance
let email = try EmailAddress("user@example.com")

// JWT creation and verification
let jwt = try JWT.hmacSHA256(
    issuer: "example.com",
    subject: "user123",
    secretKey: "your-secret-key"
)

// Type-safe HTML generation
let html = div {
    h1 { "Welcome" }
    p { "Hello, World!" }
}

// URL form encoding/decoding
struct LoginForm: Codable {
    let username: String
    let password: String
}
let decoder = Form.Decoder()
let form = try decoder.decode(LoginForm.self, from: formData)

// Date parsing from multiple formats
let parser2822 = RFC_2822.Date.Parser()
let date1 = try parser2822.parse("Mon, 15 Aug 2005 15:52:01 +0000"[...])

let parserUnix = Date.UnixEpoch.Parser()
let date2 = try parserUnix.parse("1629038521"[...])

// Domain validation
let domain = try Domain("example.com")

// Sitemap generation
let sitemap = Sitemap(urls: [
    Sitemap.URL(location: URL(string: "https://example.com/page1")!),
    Sitemap.URL(location: URL(string: "https://example.com/page2")!)
])
```

## Usage Examples

### Type-Safe Routing with Link Generation

The `ParserPrinter.href(for:)` extension method enables generating type-safe links from your route definitions:

```swift
import WebFoundation
import URLRouting

// Define your routes and create a router
enum SiteRoute {
    case home
    case article(id: Int)
}

let router = OneOf {
    Route(.case(SiteRoute.home)) {
        Path { "home" }
    }
    Route(.case(SiteRoute.article)) {
        Path { "article"; Digits() }
    }
}

// Generate type-safe links using the href extension
let homeLink = router.href(for: .home)
let articleLink = router.href(for: .article(id: 42))
```

### Form Handling with Type Safety

```swift
import WebFoundation

struct RegistrationForm: Codable {
    let email: String
    let password: String
    let acceptTerms: Bool
}

// Decode URL-encoded form data
let formData = "email=user@example.com&password=secret&acceptTerms=true"
let decoder = Form.Decoder()
let form = try decoder.decode(
    RegistrationForm.self,
    from: formData.data(using: .utf8)!
)

// Validate email using EmailAddress
let validatedEmail = try EmailAddress(form.email)
```

### HTML Generation with CSS

```swift
import WebFoundation

let page = html {
    head {
        title { "My Page" }
        style {
            """
            body { font-family: system-ui; }
            .container { max-width: 1200px; margin: 0 auto; }
            """
        }
    }
    body {
        div {
            h1 { "Welcome" }
            p { "This is type-safe HTML" }
        }
        .class("container")
    }
}
```

### Date Parsing and Formatting

```swift
import WebFoundation

// Parse RFC 2822 date
let parser2822 = RFC_2822.Date.Parser()
let rfc2822Date = try parser2822.parse("Mon, 15 Aug 2005 15:52:01 +0000"[...])

// Parse RFC 5322 date
let parser5322 = RFC_5322.Date.Parser()
let rfc5322Date = try parser5322.parse("Fri, 21 Nov 1997 09:55:06 -0600"[...])

// Parse Unix epoch
let parserUnix = Date.UnixEpoch.Parser()
let unixDate = try parserUnix.parse("1629038521"[...])

// Use Foundation extensions for date math
let tomorrow = Date() + 1.day
let nextWeek = Date() + 7.days
let nextMonth = Date() + 1.month
```

### JWT Token Management

```swift
import WebFoundation

// Create JWT with HMAC-SHA256
let jwt = try JWT.hmacSHA256(
    issuer: "example.com",
    subject: "user123",
    expiresIn: 3600,
    claims: ["name": "John Doe"],
    secretKey: "your-secret-key"
)

// Get token string
let tokenString = try jwt.compactSerialization()

// Verify and decode JWT
let parsedJWT = try JWT.parse(from: tokenString)
let verificationKey = VerificationKey.symmetric(string: "your-secret-key")
let isValid = try parsedJWT.verifyAndValidate(with: verificationKey)
```

## Included Libraries

### Type Safety & Domain Modeling

- **[EmailAddress](https://github.com/coenttb/swift-emailaddress-type)** - RFC 5322/6531 compliant email address validation and parsing
- **[Domain](https://github.com/coenttb/swift-domain-type)** - Type-safe domain name validation and manipulation
- **[JWT](https://github.com/coenttb/swift-jwt)** - RFC 7519 compliant JSON Web Token creation and verification using Apple's Crypto framework

### Date & Time Handling

- **[DateParsing](https://github.com/coenttb/swift-date-parsing)** - Parsers for RFC 2822, RFC 5322, and Unix epoch timestamps
- **[FoundationExtensions](https://github.com/coenttb/swift-foundation-extensions)** - Date arithmetic (`+ 1.day`), validation, and formatting utilities

### Web Standards & Routing

- **[URLFormCoding](https://github.com/coenttb/swift-url-form-coding)** - Type-safe `application/x-www-form-urlencoded` encoding and decoding
- **[URLFormCodingURLRouting](https://github.com/coenttb/swift-url-form-coding-url-routing)** - Integration layer between form encoding and URL routing
- **[URLMultipartFormCodingURLRouting](https://github.com/coenttb/swift-url-multipart-form-coding-url-routing)** - RFC 7578 compliant multipart form data handling with URLRouting integration
- **[URLRouting](https://github.com/pointfreeco/swift-url-routing)** - Point-Free's composable URL routing with bidirectional parsing and printing

### Content Generation

- **[HTML](https://github.com/coenttb/swift-html)** - Type-safe HTML and CSS generation with result builder syntax
- **[Sitemap](https://github.com/coenttb/swift-sitemap)** - XML sitemap generation following sitemaps.org protocol
- **[Builders](https://github.com/coenttb/swift-builders)** - Result builders for declarative collection and content construction

### Parsing & Infrastructure

- **[Parsing](https://github.com/pointfreeco/swift-parsing)** - Point-Free's composable parser combinator library
- **[Dependencies](https://github.com/pointfreeco/swift-dependencies)** - Dependency injection inspired by SwiftUI Environment

## Related Packages

### Dependencies

- [pointfree-html](https://github.com/coenttb/pointfree-html): A fork of pointfreeco/swift-html with extended functionality.
- [swift-builders](https://github.com/coenttb/swift-builders): A Swift package with result builders for Array, Dictionary, Set, String, and Markdown.
- [swift-date-parsing](https://github.com/coenttb/swift-date-parsing): A Swift package for parsing RFC 2822, RFC 5322, and Unix timestamp formats.
- [swift-domain-type](https://github.com/coenttb/swift-domain-type): A Swift package with a type-safe Domain model.
- [swift-emailaddress-type](https://github.com/coenttb/swift-emailaddress-type): A Swift package with a type-safe EmailAddress model.
- [swift-foundation-extensions](https://github.com/coenttb/swift-foundation-extensions): A Swift package with extensions for dates, times, and date components.
- [swift-html](https://github.com/coenttb/swift-html): The Swift library for domain-accurate and type-safe HTML & CSS.
- [swift-jwt](https://github.com/coenttb/swift-jwt): A Swift package for creating, signing, and verifying JSON Web Tokens.
- [swift-sitemap](https://github.com/coenttb/swift-sitemap): A Swift package for generating XML sitemaps.
- [swift-url-form-coding](https://github.com/coenttb/swift-url-form-coding): A Swift package for type-safe web form encoding and decoding.
- [swift-url-form-coding-url-routing](https://github.com/coenttb/swift-url-form-coding-url-routing): Integration layer between form encoding and URL routing.
- [swift-url-multipart-form-coding-url-routing](https://github.com/coenttb/swift-url-multipart-form-coding-url-routing): RFC 7578 compliant multipart form data handling with URLRouting integration.

### Used By

- [coenttb-web](https://github.com/coenttb/coenttb-web): A Swift package with tools for web development building on swift-web.

### Third-Party Dependencies

- [pointfreeco/swift-dependencies](https://github.com/pointfreeco/swift-dependencies): A dependency management library for controlling dependencies in Swift.
- [pointfreeco/swift-parsing](https://github.com/pointfreeco/swift-parsing): A parser combinator library for Swift.

## License

This project is licensed under the Apache 2.0 License. See [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.
