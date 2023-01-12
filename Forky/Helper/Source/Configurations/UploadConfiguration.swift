//
//  UploadConfiguration.swift
//  
//
//  Created by Prakhar Pandey on 07/07/22.
//

import Foundation

/// MimeType for image path extensions
public enum MimeType: String {
    case jpeg
    case png
    case gif
    case tiff
}

/// ImageData for multipart api request
public struct ImageData {
    private(set) var fileData: Data
    private(set) var name: String
    private(set) var fileName: String?
    private(set) var mimeType: MimeType
    
    /// - Parameters:
    ///   - fileData: Image Data or any file Data
    ///   - name: Parameter name
    ///   - fileName: Name for image or file
    ///   - mimeType: MimeType for image path extensions
    public init(fileData: Data, name: String, fileName: String? = nil, mimeType: MimeType) {
        self.fileData = fileData
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}

/// UploadConfiguration: Use it for upload any data
public struct UploadConfiguration: Configuration {
    private(set) var endPoint: String
    private(set) var imageData: [ImageData]
    private(set) var method: HTTPMethod = .post
    private(set) var body: [String : String]?
    private(set) var parameters: [String : Any]?
    
    /// - Parameters:
    ///   - endPoint: Endpoint without base url
    ///   - imageData: Image Data
    ///   - method: HTTP Methods
    ///   - body: Any additional data
    ///   - parameters: URL parameters
    public init(endPoint: String, imageData: [ImageData], method: HTTPMethod = .post, body: [String : String]? = nil, parameters: [String : Any]? = nil) {
        self.endPoint = endPoint
        self.imageData = imageData
        self.method = method
        self.body = body
        self.parameters = parameters
    }
}
