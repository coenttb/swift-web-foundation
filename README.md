# swift-web-foundation: Web Development Foundation for Swift

`swift-web-foundation` is a glue library that consolidates essential Swift packages for web development into a single, convenient import. Rather than managing multiple dependencies, this foundation provides unified access to type-safe web standards, parsing, routing, content generation, and domain modeling tools.

## Included Libraries

This foundation re-exports the following specialized packages, organized by domain:

### **Type Safety & Domain Modeling**

- **[EmailAddress](https://github.com/coenttb/swift-emailaddress-type)** - Domain-accurate and type-safe email address handling that adheres to web standards
- **[Domain](https://github.com/coenttb/swift-domain-type)** - Type-safe domain model consistent with web standards for reliable domain handling
- **[JWT](https://github.com/coenttb/swift-jwt)** - Standards-compliant JSON Web Token creation, signing, and verification using Apple's Crypto framework

### **Date & Time Handling**

- **[DateParsing](https://github.com/coenttb/swift-date-parsing)** - Comprehensive date parsing for RFC 2822, RFC 5322, and Unix epoch timestamps with robust error handling
- **[FoundationExtensions](https://github.com/coenttb/swift-foundation-extensions)** - Powerful extensions for date manipulation, validation, and formatting with intuitive operations like `date + 1.day`

### **Web Standards & Routing**

- **[URLFormCoding](https://github.com/coenttb/swift-url-form-coding)** - Type-safe encoding and decoding of `application/x-www-form-urlencoded` data with flexible parsing strategies
- **[URLFormCodingURLRouting](https://github.com/coenttb/swift-url-form-coding-url-routing)** - Seamless integration between form data handling and type-safe URL routing
- **[URLMultipartFormCodingURLRouting](https://github.com/coenttb/swift-url-multipart-form-coding-url-routing)** - RFC 7578 compliant multipart form data handling with secure file uploads and URLRouting integration
- **[URLRouting](https://github.com/pointfreeco/swift-url-routing)** - Point-Free's powerful URL routing library for type-safe navigation

### **Content Generation**

- **[HTML](https://github.com/coenttb/swift-html)** - Type-safe HTML and CSS generation with SwiftUI-like syntax, supporting server-side rendering and responsive design
- **[Sitemap](https://github.com/coenttb/swift-sitemap)** - XML sitemap generation following sitemaps.org protocol with full metadata support
- **[Builders](https://github.com/coenttb/swift-builders)** - Result builders for creating collections and content with declarative, SwiftUI-like syntax

### **Parsing & Infrastructure**

- **[Parsing](https://github.com/pointfreeco/swift-parsing)** - Point-Free's composable, performant, and general-purpose parsing library for transforming unstructured data
- **[Dependencies](https://github.com/pointfreeco/swift-dependencies)** - SwiftUI Environment-inspired dependency management for controllable and testable applications

## Usage

Instead of importing multiple individual packages:

```swift
import EmailAddress
import JWT  
import URLFormCoding
import HTML
import Sitemap
// ... and many more
```

Simply import the foundation:

```swift
import WebFoundation

// All functionality is now available:
let email = EmailAddress("user@example.com")
let jwt = try JWT.signed(/* ... */)
let form = try URLFormDecoder().decode(LoginForm.self, from: data)
let html = div { "Hello, World!" }
let sitemap = Sitemap(urls: urls)
```

## Installation

To use **swift-web-foundation** in your project, add it to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/swift-web-foundation.git", branch: "main")
]
```

## Related projects

### Boiler & coenttb

* [boiler](https://www.github.com/coenttb/boiler): A minimal Swift web framework for building type-safe servers
* [swift-html](https://www.github.com/coenttb/swift-html): A Swift library for domain-accurate and type-safe HTML & CSS
* [coenttb-com-server](https://www.github.com/coenttb/coenttb-com-server): The backend server for coenttb.com, written entirely in Swift and powered by [boiler](https://www.github.com/coenttb-server-vapor).

## Feedback is Much Appreciated!
  
If you’re working on your own Swift web project, feel free to learn, fork, and contribute.

Got thoughts? Found something you love? Something you hate? Let me know! Your feedback helps make this project better for everyone. Open an issue or start a discussion—I’m all ears.

> [Subscribe to my newsletter](http://coenttb.com/en/newsletter/subscribe)
>
> [Follow me on X](http://x.com/coenttb)
> 
> [Link on Linkedin](https://www.linkedin.com/in/tenthijeboonkkamp)

## License

This project is licensed under the **Apache 2.0 License**. See the [LICENSE](LICENSE).
