//
//  StatusCodes.swift
//  
//
//  Created by Prakhar Pandey on 06/07/22.
//

enum StatusCodes: Int, Equatable {
    case success = 200
    case notFound = 404
    case tooManyRequests = 429
    case underMaintenance = 503
    case sessionExpired = 401
    case logout = 403
    case logout0301 = 0301
    case parsingError = 20002
    case dataNotAvailable = 1166
    case forceUpdate = 1169
    case optionalUpdate = 1269
}

struct StatusCodeModel: Decodable {
    private(set) var statusCode: Int?
    private(set) var code: Int?
    private(set) var status_code: Int?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let code = try? values.decode(Int.self, forKey: .code) {
            self.code = code
        }
        if let code = try? values.decode(String.self, forKey: .code) {
            self.code = Int(code)
        }
        if let code = try? values.decode(Int.self, forKey: .statusCode) {
            self.statusCode = code
        }
        if let code = try? values.decode(String.self, forKey: .status_code) {
            self.status_code = Int(code)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case code
        case status_code
    }
}

/// Error model used for API error decoding
struct ErrorModel: Decodable {
    private(set) var error_message: String?
    private(set) var error: String?
    private(set) var code: Int?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let errorMessage = try? values.decode(String.self, forKey: .error_message) {
            self.error_message = errorMessage
        }
        if let code = try? values.decode(Int.self, forKey: .code) {
            self.code = code
        }
        if let code = try? values.decode(String.self, forKey: .code) {
            self.code = Int(code)
        }
        if let errorMessage = try? values.decode(String.self, forKey: .error) {
            self.error = errorMessage
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case error_message
        case error
        case code
    }
}
