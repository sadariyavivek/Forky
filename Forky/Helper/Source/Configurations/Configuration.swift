//
//  Configuration.swift
//  
//
//  Created by Prakhar Pandey on 04/07/22.
//

/// HTTP Methods
public enum HTTPMethod: String {
    case delete
    case get
    case head
    case post
    case put
    case patch
}

/// Request Encodings
public enum Encoding {
    case json
    case urlEncoding
    case urlEncodingQueryString
}

/// Configuration Protocol
public protocol Configuration {}
