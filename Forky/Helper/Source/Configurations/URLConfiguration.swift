//
//  File.swift
//  
//
//  Created by Prakhar Pandey on 06/07/22.
//

/// URLConfiguration: Use it for URL API request
public struct URLConfiguration: Configuration {
    private(set) var endPoint: String
    private(set) var method: HTTPMethod
    private(set) var headers: [String : String]?
    private(set) var parameters: [String : Any]?
    private(set) var encoding: Encoding = .urlEncoding
    
    /// - Parameters:
    ///   - endPoint: Endpoints without base url
    ///   - method: such as `GET`, `POST`, etc
    ///   - headers: use this params for header fields
    ///   - parameters: use this params for additional parameter
    ///   - encoding: use this param for ``Encoding`` type
    public init(endPoint: String, method: HTTPMethod, headers: [String : String]? = nil, parameters: [String : Any]? = nil, encoding: Encoding = .urlEncoding) {
        self.endPoint = endPoint
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.encoding = encoding
    }
}
