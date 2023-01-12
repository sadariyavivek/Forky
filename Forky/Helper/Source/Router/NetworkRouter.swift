//
//  NetworkRouter.swift
//  
//
//  Created by Prakhar Pandey on 04/07/22.
//

import UIKit

@available(iOS 13.0, *)
    /* This is the decision maker layer for all request */
final class NetworkRouter {
    
    private init() {}
    
    @discardableResult
    static func request(_ configuration: Configuration, cache: CacheConfiguration?) async -> Result<Data, Error> {
        if type(of: configuration) == MockConfiguration.self {
            return await routeToMock(configuration)
        } else if type(of: configuration) == UploadConfiguration.self {
            return await routeToUploadMultipart(configuration)
        } else if let cacheConfiguration = cache {
            return await validateCacheAndRedirectToURLServiceIfNeeded(configuration, cache: cacheConfiguration)
        } else if type(of: configuration) == URLConfiguration.self {
            return await routeToURLRequest(configuration)
        } else {
            return .failure(URLServiceError.unknownConfiguration)
        }
    }
    
    static func download(_ urlString: String?, in imageView: UIImageView?) async {
        await DownloadService.default.downloadImage(urlString, in: imageView)
    }
    
    static func requestSocket(_ configuration: Configuration) throws {
        try routeToSocket(configuration)
    }
}

@available(iOS 13.0, *)
extension NetworkRouter {
    
    static func setDelegate(_ delegate: NetworkLayerDelegate?) {
        URLService.default.delegate = delegate
    }
    
    static func setSocketDelegate(_ delegate: SocketServiceDelegate?) {
        //SocketService.default.delegate = delegate
    }
    
    static func set(header: Header?) {
        URLService.default.headers = header
        //SocketService.default.header = header
    }
    
    static private func routeToMock(_ configuration: Configuration) async -> Result<Data, Error> {
        guard let mockConfiguration = configuration as? MockConfiguration else {
            return .failure(URLServiceError.serializationFailed)
        }
        return await MockService.default.process(mockConfiguration)
    }
    
    static private func routeToUploadMultipart(_ configuration: Configuration) async -> Result<Data, Error> {
        guard let uploadConfiguration = configuration as? UploadConfiguration else {
            return .failure(URLServiceError.invalidConfiguration)
        }
        let urlResult = await URLService.default.uploadMultipart(uploadConfiguration)
        switch urlResult {
        case .success(let object):
            return .success(object.data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static private func routeToURLRequest(_ configuration: Configuration, isCache: Bool = false) async -> Result<Data, Error> {
        guard let urlConfiguration = configuration as? URLConfiguration else {
            return .failure(URLServiceError.invalidConfiguration)
        }
        
        let urlResult = await URLService.default.fetch(urlConfiguration)
        switch urlResult {
        case .success(let object):
            if isCache {
                await CachingService.default.store(object.data, request: object.request, response: object.response)
            }
            return .success(object.data)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static private func routeToCache(_ configuration: CacheConfiguration, urlConfiguration: URLConfiguration) async -> Result<Data, Error> {
        let result = URLService.default.createRequest(urlConfiguration)
        switch result {
        case .success(let request):
            return await CachingService.default.fetch(configuration, request: request)
        case .failure(let error): return .failure(error)
        }
    }
    
    static private func validateCacheAndRedirectToURLServiceIfNeeded(_ configuration: Configuration, cache: CacheConfiguration) async -> Result<Data, Error> {
        if let urlConfiguration = configuration as? URLConfiguration {
            let result = await routeToCache(cache, urlConfiguration: urlConfiguration )
            switch result {
            case .success(let data):
                return .success(data)
            case .failure:
                return await routeToURLRequest(configuration, isCache: true)
            }
        } else {
            return .failure(URLServiceError.invalidConfiguration)
        }
    }
    
    static private func routeToSocket(_ configuration: Configuration) throws {
        guard let socketConfiguration = configuration as? SocketConfiguration else {
            throw URLServiceError.invalidConfiguration
        }
        
        switch socketConfiguration {
        case .subscribeAndListen(let topic): break
            //try SocketService.default.subscribeAndListen(topic)
            
        case .unsubscribe(let topics): break
            //try SocketService.default.unsubscribe(topics)
            
        case .disconnect: break
            //SocketService.default.disconnect()
        }
    }
}
