//
//  Logger.swift
//  
//
//  Created by Prakhar Pandey on 07/07/22.
//

import Foundation

enum LoggerType: String {
    case cache = "Cache"
    case jsonDecoder = "JSON Decoder"
    case network = "Network"
    case mock = "Mock"
    case socket = "Socket"
}

/// Parameter required for error loggin
struct LogParam {
    
    private(set) var parameters: Any?
    private(set) var data: Data?
    private(set) var request: URLRequest?
    private(set) var response: URLResponse?
    private(set) var error: Error?
    private(set) var type: LoggerType
    
    internal init(parameters: Any? = nil, data: Data? = nil, request: URLRequest? = nil, response: URLResponse? = nil, error: Error? = nil, type: LoggerType = .network) {
        self.parameters = parameters
        self.data = data
        self.request = request
        self.response = response
        self.error = error
        self.type = type
    }
}

@available(iOS 13.0, *)
/// Error Logger
struct Logger {
    
    static private var isLoggingEnabled: Bool = NW.isLoggingEnabled
    
    static func log(_ logParam: LogParam) {
        guard isLoggingEnabled else { return }
        
        var errorString: String = ""
        
        errorString = ""
        errorString += " \n"
        errorString += "========== \(logParam.type.rawValue) Response ==========\n"
        errorString += " \n"
        
        let isCancelled = (logParam.error as? NSError)?.code == NSURLErrorCancelled
        if isCancelled {
            if let request = logParam.request, let url = request.url {
                errorString += "Cancelled request: \(url.absoluteString)\n"
                errorString += " \n"
            }
        } else {
            if let request = logParam.request, let url = request.url {
                errorString += "*** Request ***\n"
                errorString += " "
                errorString += " \n"
                errorString += "URL: \(url.absoluteString)\n"
                errorString += " \n"
            }
            
            if let requestMethodType = logParam.request?.httpMethod {
                errorString += "Http Method: \(requestMethodType)\n"
                errorString += " \n"
            }
            
            if let headers = logParam.request?.allHTTPHeaderFields {
                errorString += "Headers: \(headers)\n"
                errorString += " \n"
            }
            
            if let parameters = logParam.parameters {
                do {
                    guard JSONSerialization.isValidJSONObject(parameters) == true else {
                        guard let error = logParam.error else {
                            errorString += "Invalid Error\n"
                            return
                        }
                        errorString += "Invalid JSON format: \(error))\n"
                        return
                    }
                    let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                    let string = String(data: data, encoding: .utf8)
                    if let string = string {
                        errorString += "Parameters: \(string)\n"
                        errorString += " \n"
                    }
                } catch let error as NSError {
                    errorString += "Failed pretty printing parameters: \(parameters), error: \(error)\n"
                    errorString += " \n"
                }
            }
            
            if let response = logParam.response as? HTTPURLResponse {
                errorString += "*** Response ***\n"
                errorString += " \n"
                
                errorString += "Headers: \(response.allHeaderFields)\n"
                errorString += " \n"
                
                errorString += "Status code: \(response.statusCode)\n"
                errorString += " \n"
            }
            
            if let data = logParam.data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    errorString += "Response Data: ==> \(String(describing: json))\n"
                } catch let error {
                    errorString += "Failed to convert data to JSON: \(error)\n"
                }
                errorString += " \n"
            }
        }
        
        if let error = logParam.error as? DecodingError {
            errorString += "Failed to parse JSON: \(error)\n"
            errorString += " \n"
        } else if let error = logParam.error as? NSError  {
            errorString += "Unknown error: \(error)\n"
            errorString += " \n"
        }
        
        if let curl = logParam.request?.curlString {
            errorString += "*** Curl Request: ***\n\n"
            errorString += curl
            errorString += " \n\n"
        }
        
        errorString += "================= ~ ==================\n"
        errorString += " \n"
        print(errorString)
    }
}

extension URLRequest {
    /**
     Returns a cURL command representation of this URL request.
     */
    fileprivate var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#
        
        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        
        var command = [baseCommand]
        
        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }
        
        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }
        
        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }
        
        return command.joined(separator: " \\\n\t")
    }
}
