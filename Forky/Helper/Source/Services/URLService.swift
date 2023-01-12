//
//  URLService.swift
//  
//
//  Created by Prakhar Pandey on 04/07/22.
//

import Foundation

/// This is the service to fetch or upload data.
@available(iOS 13.0, *)
final class URLService {
    
    static let `default` = URLService()
    weak var delegate: NetworkLayerDelegate?
    internal var headers: Header?

    private init() {}
    
    func fetch(_ configuration: URLConfiguration) async -> Result<Response, Error> {
        await handleResult(createRequest(configuration), configuration.parameters)
    }
    
    func uploadMultipart(_ configuration: UploadConfiguration) async -> Result<Response, Error> {
        await handleResult(MultipartFormData(configuration, headers: self.headers).urlRequest(), configuration.parameters)
    }
}
