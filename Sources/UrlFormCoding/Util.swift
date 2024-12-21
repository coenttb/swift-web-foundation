import Foundation
import UrlFormEncoding

extension UrlFormDecoder {
  @MainActor public static let `default`: UrlFormDecoder = {
        let decoder = UrlFormDecoder()
        decoder.parsingStrategy = .bracketsWithIndices
        return decoder
    }()
}

// public let formDecoder: UrlFormDecoder = {
//    let decoder = UrlFormDecoder()
//    decoder.parsingStrategy = .bracketsWithIndices
//    return decoder
// }()

extension DateFormatter {
  @MainActor public static let form: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
