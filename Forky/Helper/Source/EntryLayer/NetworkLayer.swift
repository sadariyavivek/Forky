//
//  NetworkLayer.swift
//
//
//  Created by Prakhar Pandey on 04/07/22.
//

import UIKit

@available(iOS 13.0, *)
/// Shortcut to access ``NetworkLayer.default`` object
public let NW = NetworkLayer.default

@available(iOS 13.0, *)
public class NetworkLayer {
    
    public static let `default` = NetworkLayer()
    
    /// Use this properties to set socket base url.
    private(set) var socketBaseURL: String?
    
    /// Use this properties to set network log off or on.
    public var isLoggingEnabled: Bool = true
    
    private init() {}
    
    /// This method will be use to register delegate once for with name``NetworkLayerDelegate``.
    /// - Parameter delegate: ``NetworkLayerDelegate``
    public func register(_ delegate: NetworkLayerDelegate?) {
        NetworkRouter.setDelegate(delegate)
    }
    
    /// This method will be use to register delegate once for with name``SocketServiceDelegate``.
    /// - Parameter delegate: ``SocketServiceDelegate``
    public func register(_ delegate: SocketServiceDelegate?) {
        NetworkRouter.setSocketDelegate(delegate)
    }
    
    /// Add HTTP headers
    /// - Parameter header: Header
    public func set(header: Header) {
        NetworkRouter.set(header: header)
    }
    
    /// Add socket URL
    /// - Parameter url: String
    public func set(socket url: String) {
        socketBaseURL = url
    }
    
    /// This method can be use to request data from server or upload data to server.
    /// - Parameters:
    ///   - configuration: Use following configuration ``URLConfiguration``, ``SocketConfiguration``, ``MockConfiguration``, ``UploadConfiguration``.
    ///   - cache: ``CacheConfiguration`` will be use to set cache.
    /// - Returns: It will return result  as``Data`` or ``Error``.
    @discardableResult
    public func request(_ configuration: Configuration, cache: CacheConfiguration? = nil) async -> Result<Data, Error> {
        await NetworkRouter.request(configuration, cache: cache)
    }
    
    /// This method can be use to download image from image url.
    /// - Parameters:
    ///   - urlString: Pass the image url  from where image is going to download
    ///   - imageView: Pass the imageView object to which image is going to set
    public func download(_ urlString: String?, in imageView: UIImageView?) async {
        await NetworkRouter.download(urlString, in: imageView)
    }
    
    /// This method can be use to request data from socket.
    /// - Parameter configuration: Pass ``SocketConfiguration`` object for socket request.
    public func requestSocket(_ configuration: Configuration) throws {
        try NetworkRouter.requestSocket(configuration)
    }
}
