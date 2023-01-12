//
//  URLService+Extension.swift
//  
//
//  Created by Prakhar Pandey on 08/07/22.
//

import Foundation

@available(iOS 13.0, *)
extension URLService {
    
    internal func parseStatusCode(_ data: Data) throws -> StatusCodeModel {
        try JSONDecoder().decode(StatusCodeModel.self, from: data)
    }
    
    internal func parseErrorMessage(_ data: Data) throws -> NSError {
        let model = try JSONDecoder().decode(ErrorModel.self, from: data)
        return NSError(domain: "API", code: model.code ?? 0, userInfo: [NSLocalizedDescriptionKey: model.error_message ?? model.error as Any])
    }
    
    internal func parseErrorDictionary(_ data: Data) -> [String : Any] {
        do {
            let model = try JSONDecoder().decode(ErrorModel.self, from: data)
            return ["error_message" : model.error_message ?? model.error as Any, "error" : model.error_message ?? model.error as Any]
        } catch {
            let logParam = LogParam(error: error)
            Logger.log(logParam)
            return ["error_message" : "", "error" : ""]
        }
    }
    
    internal func isValidResponseStatusCode(_ responseStatusCode: Int) -> Bool { // Response status code verification
        switch responseStatusCode {
        case 200...299: return true
        default: return false
        }
    }
    
    internal func isValidDataStatusCode(_ dataStatusCode: Int, error dictionary: [String : Any]) -> Bool { // Data status code verification
        switch StatusCodes(rawValue: dataStatusCode) {
        case .success: return true
        case .underMaintenance: delegate?.underMaintenance(dictionary); return false
        case .logout, .logout0301, .sessionExpired: delegate?.logout(); return false
        case .tooManyRequests: delegate?.userBlocked(); return false
        case .forceUpdate: delegate?.forceUpdate(); return false
        case .optionalUpdate: delegate?.optionalUpdate(dictionary); return false
        default: return true
        }
    }
    
    internal func createRequest(_ configuration: URLConfiguration) -> Result<URLRequest, URLServiceError> {
        guard let url = URL(string: configuration.endPoint) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = configuration.method.rawValue.uppercased()
        request.timeoutInterval = 60 // API timeout Seconds
        
        for item in configuration.headers ?? [:] {
            request.setValue(item.value, forHTTPHeaderField: item.key)
        }
        
        let urlRequest = request
        
        switch configuration.encoding {
        case .json:
            return URLService.encode(urlRequest, with: configuration.parameters)
        default:
            return URLService.encode(urlRequest, with: configuration.parameters, encoding: configuration.encoding)
        }
    }
}

extension URLRequest {
    
    func deviceName(_ deviceName: String) -> Self {
        var request = self
        request.setValue(deviceName, forHTTPHeaderField: HeaderField.deviceModel.rawValue)
        return request
    }
    
    func idString(_ idString: String) -> Self {
        var request = self
        request.setValue(idString, forHTTPHeaderField: HeaderField.playerId.rawValue)
        return request
    }
    
    func appVersion(_ appVersion: String) -> Self {
        var request = self
        request.setValue(appVersion.replacingOccurrences(of: ".", with: ""), forHTTPHeaderField: HeaderField.appVersion.rawValue)
        return request
    }
    
    func systemVersion(_ systemVersion: String) -> Self {
        var request = self
        request.setValue(systemVersion, forHTTPHeaderField: HeaderField.systemVersion.rawValue)
        return request
    }
    
    func uuid(_ uuid: String) -> Self {
        var request = self
        request.setValue(uuid, forHTTPHeaderField: HeaderField.uuid.rawValue)
        return request
    }
    
    func project(_ project: String) -> Self {
        var request = self
        request.setValue(project, forHTTPHeaderField: HeaderField.platform.rawValue)
        return request
    }
    
    func contentType(_ contentType: String) -> Self {
        var request = self
        request.setValue(contentType, forHTTPHeaderField: HeaderField.contentType.rawValue)
        return request
    }
    
    func platform(_ platform: String) -> Self {
        var request = self
        request.setValue(platform, forHTTPHeaderField: HeaderField.deviceFamily.rawValue)
        return request
    }
    
    func authorization(_ authorization: String?) -> Self {
        var request = self
        if let auth = authorization, !auth.isEmpty {
            request.setValue("Bearer \(auth)", forHTTPHeaderField: HeaderField.authorization.rawValue)
        }
        return request
    }
    
    func deviceMake(_ deviceMake: String) -> Self {
        var request = self
        request.setValue(deviceMake, forHTTPHeaderField: HeaderField.deviceMake.rawValue)
        return request
    }
    
    func language(_ language: String) -> Self {
        var request = self
        request.setValue(language, forHTTPHeaderField: HeaderField.language.rawValue)
        return request
    }
}
