import Foundation

struct DeepLTranslator {
    enum TranslationError: LocalizedError {
        case badResponse(statusCode: Int, body: String)
        case missingTranslation

        var errorDescription: String? {
            switch self {
            case .badResponse(let statusCode, let body):
                return "DeepL error \(statusCode): \(body)"
            case .missingTranslation:
                return "DeepL returned no translation."
            }
        }
    }

    let apiKey: String
    let isFreePlan: Bool

    func translate(_ text: String, from source: String, to target: String) async throws -> String {
        let base = isFreePlan ? "https://api-free.deepl.com" : "https://api.deepl.com"
        let url = URL(string: "\(base)/v2/translate")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")

        //Recommended auth (header)
        request.setValue("DeepL-Auth-Key \(apiKey)", forHTTPHeaderField: "Authorization")

        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "text", value: text),
            URLQueryItem(name: "source_lang", value: source), // "EN" or "AR"
            URLQueryItem(name: "target_lang", value: target)  // "AR" or "EN"
        ]
        request.httpBody = components.query?.data(using: .utf8)

        let (data, response) = try await URLSession.shared.data(for: request)
        let bodyString = String(data: data, encoding: .utf8) ?? ""

        guard let http = response as? HTTPURLResponse else {
            throw TranslationError.badResponse(statusCode: -1, body: bodyString)
        }
        guard (200..<300).contains(http.statusCode) else {
            throw TranslationError.badResponse(statusCode: http.statusCode, body: bodyString)
        }

        struct Resp: Decodable {
            struct Item: Decodable { let text: String }
            let translations: [Item]
        }

        let decoded = try JSONDecoder().decode(Resp.self, from: data)
        guard let result = decoded.translations.first?.text else {
            throw TranslationError.missingTranslation
        }
        return result
    }
}




