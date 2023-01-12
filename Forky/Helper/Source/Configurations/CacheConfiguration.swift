//
//  File.swift
//  
//
//  //  Created by Vivek Patel on 12/01/23.
//

import Foundation

/// CacheConfiguration: Use it to pass configuration for cache in api request.
public struct CacheConfiguration {
    private(set) var timeInterval: TimeInterval = 0.0
    private(set) var _forceRefresh: Bool = false
    
    /// Expiry time for data storage
    /// - Parameter timeInterval: Of type Double
    public init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    /// Use it for pull to refresh
    /// - Returns: It will return CacheConfiguration for pull to refresh
    public static func forceRefresh() -> CacheConfiguration {
        return CacheConfiguration(forceRefresh: true)
    }
    
    private init(forceRefresh: Bool) {
        self._forceRefresh = forceRefresh
    }
}
