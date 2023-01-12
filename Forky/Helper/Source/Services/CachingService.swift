//
//  CachingService.swift
//  
//
//  Created by Prakhar Pandey on 04/07/22.
//

import Foundation

@available(iOS 13.0, *)
final class CachingService {
    
    static let `default` = CachingService()
    private let kUrlCacheExpiresKey = "cacheTimeInterval"
    private init() {}

    func fetch(_ configuration: CacheConfiguration, request: URLRequest) async -> Result<Data, Error> {
        guard let result = URLCache.shared.cachedResponse(for: request),
              let userInfo = result.userInfo,
              let cacheDate = userInfo[kUrlCacheExpiresKey] as? Date else {
            return .failure(URLServiceError.cacheNotFound)
        }
        
        /* Check if the cache data is expired */
        /* Remove cache when force refresh is triggered */
        if (cacheDate.timeIntervalSinceNow < -configuration.timeInterval) || configuration._forceRefresh {
            /* remove old cache request */
            await remove(request)
            return .failure(URLServiceError.cacheRemoved)
        } else {
            /* The cache request is still valid */
            Logger.log(LogParam(data: result.data, request: request, type: .cache))
            return .success(result.data)
        }
    }
    
    func store(_ data: Data, request: URLRequest, response: URLResponse) async {
        var userInfo: [String : Any] = [:]
        userInfo[kUrlCacheExpiresKey] = Date()
        
        let newCachedResponse = CachedURLResponse(response: response, data: data, userInfo: userInfo, storagePolicy: .allowed)
        
        URLCache.shared.storeCachedResponse(newCachedResponse, for: request)
    }
    
    func remove(_ request: URLRequest) async {
        URLCache.shared.removeCachedResponse(for: request)
    }
    
    func removeAll() async {
        URLCache.shared.removeAllCachedResponses()
    }
}
