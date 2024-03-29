//
//  ParamEncoding.swift
//  
//
//  //  Created by Vivek Patel on 12/01/23.
//

import Foundation

extension NSNumber {
    fileprivate var isBool: Bool {
        String(cString: objCType) == "c"
    }
}

extension CharacterSet {
    /// Creates a CharacterSet from RFC 3986 allowed characters.
    ///
    /// RFC 3986 states that the following characters are "reserved" characters.
    ///
    /// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
    /// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
    ///
    /// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
    /// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
    /// should be percent-escaped in the query string.
    public static let afURLQueryAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
    }()
}

enum Destination {
    /// Applies encoded query string result to existing query string for `GET`, `HEAD` and `DELETE` requests and
    /// sets as the HTTP body for requests with any other HTTP method.
    case methodDependent
    /// Sets or appends encoded query string result to existing query string.
    case queryString
    
    func encodesParametersInURL(for method: HTTPMethod) -> Bool {
        switch self {
        case .methodDependent: return [.get, .head, .delete].contains(method)
        case .queryString: return true
        }
    }
}

/// Configures how `Array` parameters are encoded.
public enum ArrayEncoding {
    /// An empty set of square brackets is appended to the key for every value. This is the default behavior.
    case brackets
    /// No brackets are appended. The key is encoded as is.
    case noBrackets
    
    func encode(key: String) -> String {
        switch self {
        case .brackets:
            return "\(key)[]"
        case .noBrackets:
            return key
        }
    }
}

/// Configures how `Bool` parameters are encoded.
public enum BoolEncoding {
    /// Encode `true` as `1` and `false` as `0`. This is the default behavior.
    case numeric
    /// Encode `true` and `false` as string literals.
    case literal
    
    func encode(value: Bool) -> String {
        switch self {
        case .numeric:
            return value ? "1" : "0"
        case .literal:
            return value ? "true" : "false"
        }
    }
}

@available(iOS 13.0, *)
extension URLService {
    /// To be used for JSON encoding
    /// - Parameters:
    ///   - urlRequest: URLRequest
    ///   - parameters: [String : Any]?
    /// - Returns: Encoded Result<URLRequest, URLServiceError>
    static func encode(_ urlRequest: URLRequest, with parameters: [String : Any]?) -> Result<URLRequest, URLServiceError> {
        var urlRequest = urlRequest
        guard let parameters = parameters else { return .success(urlRequest) }
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            if urlRequest.allHTTPHeaderFields?["Content-Type"] == nil {
                urlRequest.allHTTPHeaderFields?.updateValue("application/json", forKey: "Content-Type")
            }
            
            urlRequest.httpBody = data
            return .success(urlRequest)
        } catch {
            return .failure(.jsonEncodingFailed(error))
        }
    }
    
    /// To be used for URL encoding
    /// - Parameters:
    ///   - urlRequest: URLRequest
    ///   - parameters: [String : Any]?
    ///   - encoding: Encoding `JSON` or `URLEncoding`
    /// - Returns: Encoded Result<URLRequest, URLServiceError>
    static func encode(_ urlRequest: URLRequest, with parameters: [String : Any]?, encoding: Encoding) -> Result<URLRequest, URLServiceError> {
        var urlRequest = urlRequest
        
        guard let parameters = parameters else { return .success(urlRequest) }
        
        var destination: Destination = .methodDependent
        
        if encoding == .urlEncodingQueryString {
            destination = .queryString
        }
        
        if let method = urlRequest.httpMethod, destination.encodesParametersInURL(for: HTTPMethod(rawValue: method) ?? .get) {
            guard let url = urlRequest.url else {
                return .failure(.urlEncodingFailed)
            }
            
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
        } else {
            if urlRequest.allHTTPHeaderFields?["Content-Type"] == nil {
                urlRequest.allHTTPHeaderFields?.updateValue("application/x-www-form-urlencoded; charset=utf-8", forKey: "Content-Type")
            }
            
            urlRequest.httpBody = Data(query(parameters).utf8)
        }
        
        return .success(urlRequest)
    }
    
    private static func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    private static func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        let arrayEncoding: ArrayEncoding = .brackets
        let boolEncoding: BoolEncoding = .numeric
        
        switch value {
        case let dictionary as [String: Any]:
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        case let array as [Any]:
            for value in array {
                components += queryComponents(fromKey: arrayEncoding.encode(key: key), value: value)
            }
        case let number as NSNumber:
            if number.isBool {
                components.append((escape(key), escape(boolEncoding.encode(value: number.boolValue))))
            } else {
                components.append((escape(key), escape("\(number)")))
            }
        case let bool as Bool:
            components.append((escape(key), escape(boolEncoding.encode(value: bool))))
        default:
            components.append((escape(key), escape("\(value)")))
        }
        return components
    }
    
    private static func escape(_ string: String) -> String {
        string.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed) ?? string
    }
}
