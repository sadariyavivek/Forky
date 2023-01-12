//
//  URLServiceProcessor.swift
//  
//
//  Created by Prakhar Pandey on 08/07/22.
//

import Foundation

@available(iOS 13.0, *)
extension URLService {
    private func validateDataStatusCode(_ data: Data, response: HTTPURLResponse, request: URLRequest, parameters: [String : Any]? = nil) throws -> Result<Data, Error> {
        if isValidResponseStatusCode(response.statusCode) {
            let decodedStatusCode: StatusCodeModel? = try? parseStatusCode(data) /// Explicit requirement
            if decodedStatusCode?.status_code != nil { /// GoPay Tokenization usecase, do not remove
                let logParam = LogParam(parameters: parameters, data: data, request: request, response: response)
                Logger.log(logParam)
                return .success(data)
            }
            
            if isValidDataStatusCode(decodedStatusCode?.statusCode ?? decodedStatusCode?.code ?? 200, error: parseErrorDictionary(data)) {
                let logParam = LogParam(parameters: parameters, data: data, request: request, response: response)
                Logger.log(logParam)
                return .success(data)
            } else {
                let logParam = LogParam(parameters: parameters, data: data, request: request, response: response, error: URLServiceError.unexpectedStatusCode(response.statusCode) as NSError)
                Logger.log(logParam)
                return .failure(try parseErrorMessage(data)) /// Explicit requirement
            }
        } else {
            let logParam = LogParam(parameters: parameters, data: data, request: request, response: response, error: URLServiceError.unexpectedStatusCode(response.statusCode) as NSError)
            Logger.log(logParam)
            return .failure(try parseErrorMessage(data))
        }
    }
    
    private func process(_ request: URLRequest, _ parameters: [String : Any]?) async -> Result<Response, Error> {
        var log: (Data, URLResponse)?
        do {
            let (data, response) = try await URLSession.shared.data(from: request)
            log = (data, response)
            guard let httpResponse = response as? HTTPURLResponse else {
                let logParam = LogParam(parameters: parameters, data: data, request: request, response: response, error: URLServiceError.noResponse as NSError)
                Logger.log(logParam)
                return .failure(URLServiceError.noResponse)
            }
            let result = try validateDataStatusCode(data, response: httpResponse, request: request, parameters: parameters)
            switch result {
            case .success(let _data): return .success(Response(_data, request, response))
            case .failure(let error):
                let logParam = LogParam(parameters: parameters, data: data, request: request, response: response, error: error as NSError)
                Logger.log(logParam)
                return .failure(error)
            }
        } catch (let error as NSError) {
            let logParam = LogParam(parameters: parameters, data: log?.0, request: request, response: log?.1, error: error)
            Logger.log(logParam)
            return .failure(error)
        }
    }
    
    internal func handleResult(_ result: Result<URLRequest, URLServiceError>, _ parameters: [String : Any]?) async -> Result<Response, Error> {
        switch result {
        case .success(let request):
            let responseResult = await process(request, parameters)
            switch responseResult {
            case .success(let object):
                return .success(Response(object.data, object.request, object.response))
            case .failure(let error): return .failure(error)
            }
        case .failure(let error as NSError):
            let logParam = LogParam(parameters: parameters, error: error)
            Logger.log(logParam)
            return .failure(error)
        }
    }
}
