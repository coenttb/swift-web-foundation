//
//  ReadmeVerificationTests.swift
//  swift-web-foundation
//
//  Tests verifying all README code examples compile and work correctly
//

import Crypto
import Foundation
import Testing

@testable import WebFoundation

@Suite("README Verification")
struct ReadmeVerificationTests {

    // MARK: - Quick Start Examples (lines 47-85)

    @Test("Quick Start - Email validation")
    func quickStartEmail() throws {
        let email = try EmailAddress("user@example.com")
        #expect(email.rawValue == "user@example.com")
    }

    @Test("Quick Start - JWT creation")
    func quickStartJWT() throws {
        let jwt = try JWT.hmacSHA256(
            issuer: "example.com",
            subject: "user123",
            secretKey: "your-secret-key"
        )
        let tokenString = try jwt.compactSerialization()
        #expect(!tokenString.isEmpty)
    }

    @Test("Quick Start - HTML generation")
    func quickStartHTML() throws {
        let html = div {
            h1 { "Welcome" }
            p { "Hello, World!" }
        }
        let bytes = html.render()
        let rendered = String(decoding: bytes, as: UTF8.self)
        #expect(rendered.contains("Welcome"))
        #expect(rendered.contains("Hello, World!"))
    }

    @Test("Quick Start - URL form decoding")
    func quickStartURLFormDecoding() throws {
        struct LoginForm: Codable {
            let username: String
            let password: String
        }
        let formData = "username=test&password=secret".data(using: .utf8)!
        let decoder = Form.Decoder()
        let form = try decoder.decode(LoginForm.self, from: formData)
        #expect(form.username == "test")
        #expect(form.password == "secret")
    }

    @Test("Quick Start - Date parsing RFC 2822")
    func quickStartDateParsingRFC2822() throws {
        let parser = RFC_2822.Date.Parser()
        let date1 = try parser.parse("Mon, 15 Aug 2005 15:52:01 +0000"[...])
        #expect(date1.timeIntervalSince1970 > 0)
    }

    @Test("Quick Start - Date parsing Unix epoch")
    func quickStartDateParsingUnixEpoch() throws {
        let parser = Date.UnixEpoch.Parser()
        let date2 = try parser.parse("1629038521"[...])
        #expect(date2.timeIntervalSince1970 == 1_629_038_521)
    }

    @Test("Quick Start - Domain validation")
    func quickStartDomain() throws {
        let domain = try Domain("example.com")
        #expect(domain.rawValue == "example.com")
    }

    @Test("Quick Start - Sitemap generation")
    func quickStartSitemap() throws {
        let sitemap = Sitemap(urls: [
            Sitemap.URL(location: URL(string: "https://example.com/page1")!),
            Sitemap.URL(location: URL(string: "https://example.com/page2")!),
        ])
        let xml = sitemap.xml
        #expect(xml.contains("https://example.com/page1"))
        #expect(xml.contains("https://example.com/page2"))
    }

    // MARK: - Form Handling

    @Test("Form Handling - Registration form decoding")
    func formHandling() throws {
        struct RegistrationForm: Codable {
            let email: String
            let password: String
            let acceptTerms: Bool
        }

        let formData = "email=user@example.com&password=secret&acceptTerms=true"
        let form = try Form.Decoder().decode(
            RegistrationForm.self,
            from: formData.data(using: .utf8)!
        )

        #expect(form.email == "user@example.com")
        #expect(form.password == "secret")
        #expect(form.acceptTerms == true)

        let validatedEmail = try EmailAddress(form.email)
        #expect(validatedEmail.rawValue == "user@example.com")
    }

    // MARK: - HTML Generation

    @Test("HTML Generation - Page with CSS")
    func htmlGeneration() throws {
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

        let bytes = page.render()
        let rendered = String(decoding: bytes, as: UTF8.self)
        #expect(rendered.contains("My Page"))
        #expect(rendered.contains("Welcome"))
        #expect(rendered.contains("This is type-safe HTML"))
        #expect(rendered.contains("font-family: system-ui"))
        #expect(rendered.contains("container"))
    }

    // MARK: - Type-Safe Routing

    @Test("Type-Safe Routing - href generation (lines 93-119)")
    func typeSafeRouting() throws {
        enum SiteRoute {
            case home
            case article(id: Int)
        }

        let router = OneOf {
            Route(.case(SiteRoute.home)) {
                Path { "home" }
            }
            Route(.case(SiteRoute.article)) {
                Path {
                    "article"
                    Digits()
                }
            }
        }

        let homeLink = router.href(for: .home)
        let articleLink = router.href(for: .article(id: 42))

        #expect(homeLink.rawValue.contains("/home"))
        #expect(articleLink.rawValue.contains("/article/42"))
    }

    // MARK: - Date Parsing

    @Test("Date Parsing - RFC 2822")
    func dateParsingRFC2822() throws {
        let parser = RFC_2822.Date.Parser()
        let rfc2822Date = try parser.parse("Mon, 15 Aug 2005 15:52:01 +0000"[...])
        #expect(rfc2822Date.timeIntervalSince1970 > 0)
    }

    @Test("Date Parsing - RFC 5322")
    func dateParsingRFC5322() throws {
        let parser = RFC_5322.Date.Parser()
        let rfc5322Date = try parser.parse("Fri, 21 Nov 1997 09:55:06 -0600"[...])
        #expect(rfc5322Date.timeIntervalSince1970 > 0)
    }

    @Test("Date Parsing - Unix epoch")
    func dateParsingUnixEpoch() throws {
        let parser = Date.UnixEpoch.Parser()
        let unixDate = try parser.parse("1629038521"[...])
        #expect(unixDate.timeIntervalSince1970 == 1_629_038_521)
    }

    @Test("Date Parsing - Foundation extensions")
    func dateParsingFoundationExtensions() throws {
        withDependencies {
            $0.calendar = Calendar.current
        } operation: {
            let now = Date()
            let tomorrow = now + 1.day
            let nextWeek = now + 7.days
            let nextMonth = now + 1.month

            // Verify dates are in the future
            #expect(tomorrow > now)
            #expect(nextWeek > tomorrow)
            #expect(nextMonth > nextWeek)

            // Verify approximate intervals
            let dayInterval = tomorrow.timeIntervalSince(now)
            #expect(dayInterval > 86000 && dayInterval < 87000)  // ~24 hours

            let weekInterval = nextWeek.timeIntervalSince(now)
            #expect(weekInterval > 604000 && weekInterval < 605000)  // ~7 days
        }
    }

    // MARK: - JWT Token Management

    @Test("JWT Token Management - Create and verify")
    func jwtTokenManagement() throws {
        let jwt = try JWT.hmacSHA256(
            issuer: "example.com",
            subject: "user123",
            expiresIn: 3600,
            claims: ["name": "John Doe"],
            secretKey: "your-secret-key"
        )

        let tokenString = try jwt.compactSerialization()
        #expect(!tokenString.isEmpty)
        #expect(tokenString.split(separator: ".").count == 3)  // Header.Payload.Signature

        // Verify
        let parsedJWT = try JWT.parse(from: tokenString)
        let verificationKey = VerificationKey.symmetric(string: "your-secret-key")
        let isValid = try parsedJWT.verifyAndValidate(with: verificationKey)
        #expect(isValid)
        #expect(parsedJWT.payload.sub == "user123")
        #expect(parsedJWT.payload.iss == "example.com")
    }
}
