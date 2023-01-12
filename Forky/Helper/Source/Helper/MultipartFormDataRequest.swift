//
//  MultipartFormDataRequest.swift
//
//
//  Created by Prakhar Pandey on 07/07/22.
//

import Foundation

@available(iOS 13.0, *)

/// Multipart data form
struct MultipartFormData {
    private let boundary: String = "Boundary-\(UUID().uuidString)"
    private let configuration: UploadConfiguration
    private let headers: Header?
    
    init(_ configuration: UploadConfiguration, headers: Header?) {
        self.headers = headers
        self.configuration = configuration
    }
    
    func urlRequest() -> Result<URLRequest, URLServiceError> {
        guard let url = URL(string: configuration.endPoint) else {
            return .failure(URLServiceError.invalidURL)
        }
        let request = URLRequest(url: url)
        let httpBody = NSMutableData()
        
        if let bodyParameters = configuration.body {
            for item in bodyParameters {
                httpBody.appendString(convertFormField(named: item.key, value: item.value, using: boundary))
            }
        }
        
        configuration.imageData.forEach { data in
            httpBody.append(
                convertFileData(
                    fieldName: data.name,
                    fileName: data.fileName ?? "",
                    mimeType: data.mimeType.rawValue,
                    fileData: data.fileData,
                    using: boundary))
        }
        
        guard let headers = headers else {
            return .failure(.missingHeaders)
        }
        
        var urlRequest = request.platform(headers.platform)
            .uuid(headers.uuid)
            .language(headers.language)
            .deviceName(headers.deviceName)
            .deviceMake(headers.deviceMake)
            .idString(headers.idString)
            .appVersion(headers.appVersion)
            .authorization(headers.authorization)
            .systemVersion(headers.systemVersion)
            .project(headers.project)
        
        urlRequest.httpMethod = configuration.method.rawValue.uppercased()
        urlRequest.timeoutInterval = 300 // API timeout Seconds
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        httpBody.appendString("--\(boundary)--")
        urlRequest.httpBody = httpBody as Data
        return .success(urlRequest)
    }
    
    /// Convert to text form field
    /// - Parameters:
    ///   - name: Dictionary key
    ///   - value: Dictionary value
    ///   - boundary: Boundary
    /// - Returns: String
    private func convertFormField(named name: String, value: String, using boundary: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        return fieldString
    }
    
    /// Convert image data and other fields to data
    /// - Parameters:
    ///   - fieldName: Dictionary key name
    ///   - fileName: File name for image
    ///   - mimeType: Image mime type
    ///   - fileData: Image data
    ///   - boundary: Boundary
    /// - Returns: Data
    private func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
        let data = NSMutableData()
        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.appendString("\r\n")
        return data as Data
    }
}

fileprivate extension NSMutableData {
    /// Append data to a string
    /// - Parameter string: String
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
