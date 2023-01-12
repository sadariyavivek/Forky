//
//  File.swift
//  
//
//  Created by Prakhar Pandey on 06/07/22.
//

enum URLServiceError: Error, CustomStringConvertible {
    case cacheNotFound
    case cacheRemoved
    case dataNotFound
    case emptySocketListener
    case fileNotFound
    case failedToEstablishSocketConnection
    case invalidConfiguration
    case invalidURL
    case invalidPDF
    case jsonEncodingFailed(_ error: Error)
    case message(_ message: String)
    case missingHeaders
    case noResponse
    case subscribeToTopicFirst
    case serializationFailed
    case socketAlreadyDisconnected
    case unexpectedStatusCode(_ code: Int)
    case unknown
    case unknownConfiguration
    case urlEncodingFailed
    case unsubscribeToTopicFirst
    case unsupportedImageType
    
    var description: String {
        switch self {
        case .cacheNotFound: return "Requested cache data not found"
        case .cacheRemoved: return "Requested cache data has been removed"
        case .dataNotFound: return "Data not found"
        case .emptySocketListener: return "Provide socket listener"
        case .fileNotFound: return "File does not exist"
        case .failedToEstablishSocketConnection:  return "Socket failed to establish a connection"
        case .invalidConfiguration: return "Provided configuration is not valid"
        case .invalidURL: return "URL is invalid"
        case .invalidPDF: return "PDF is invalid"
        case .jsonEncodingFailed(let error): return "Failed to encode JSON - \(error)"
        case .message(let message): return message
        case .missingHeaders: return "Missing request headers"
        case .noResponse: return "No response received"
        case .subscribeToTopicFirst: return "Subscribe to a topic before listening to port"
        case .serializationFailed: return "Failed to parse data"
        case .socketAlreadyDisconnected: return "Socket already disconnected"
        case .unexpectedStatusCode(let error): return "Unexpected status code - \(error)"
        case .unknown: return "Unknown error occurred"
        case .unknownConfiguration: return "Provided configuration is unknown"
        case .urlEncodingFailed: return "Failed to encode URL"
        case .unsubscribeToTopicFirst: return "Unsubscribe to a topic before switching off the port"
        case .unsupportedImageType: return "Unsupported image type"
        }
    }
}
